import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../core/error/exeption.dart';
import '../../data/converters/db_dto_task_converter.dart';
import '../../data/converters/domain_db_task_converter.dart';
import '../../data/converters/domain_dto_task_converter.dart';
import '../../logger.dart';
import '../models/task_model.dart';
import '../../data/services/tasks_db/tasks_db.dart';
import '../../data/services/tasks_server/tasks_server.dart';

abstract interface class TasksRepository {
  Future<List<TaskModel>> getDBTasks();

  Future<List<TaskModel>?> getServerTasks();

  Future<void> addDBTask(TaskModel task);

  Future<void> addServerTask(TaskModel task);

  Future<void> updateDBTask(String id, TaskModel task);

  Future<void> updateServerTask(String id, TaskModel task);

  Future<void> removeDBTask(String id);

  Future<void> removeServerTask(String id);
}

@LazySingleton(as: TasksRepository)
class TasksRepositoryImpl implements TasksRepository {
  final SharedPreferences prefs;
  final TasksServer server;
  final TasksDB db;

  TasksRepositoryImpl({
    required this.prefs,
    required this.server,
    required this.db,
  });

  @override
  Future<List<TaskModel>> getDBTasks() async {
    final dbTasksList = await db.getTasksList();
    final tasksList = dbTasksList.map((dbTask) => dbTask.toDomain()).toList();
    prioritySort(tasksList);
    return tasksList;
  }

  @override
  Future<List<TaskModel>?> getServerTasks() async {
    final localRevision = prefs.getInt(sharedPreferencesRevisionKey);
    try {
      final serverTasks = await server.getTasksList();
      final hasUnsyncLocalChanges = prefs.getBool(hasLocalChangesKey) ?? false;
      final serverRevision = prefs.getInt(sharedPreferencesRevisionKey)!;
      if (!hasUnsyncLocalChanges && localRevision == serverRevision) {
        logger.i('Data is synchronized with the server');
        return null;
      } else if (!hasUnsyncLocalChanges && localRevision != serverRevision) {
        logger.i('Server has newer data, downloading it');
        final tasksList = serverTasks.list
            .map((serverTask) => serverTask.toDomain())
            .toList();
        prioritySort(tasksList);
        final newDBTasks =
            serverTasks.list.map((serverTask) => serverTask.toDB()).toList();
        await db.patchTasks(newDBTasks);
        return tasksList;
      } else if (hasUnsyncLocalChanges && localRevision == serverRevision) {
        logger.i('Server has old data, uploading data to database');
        final dbTasksList = await db.getTasksList();
        final newDtoTasks =
            dbTasksList.map((dbTask) => dbTask.toDto()).toList();
        await server.patchTasks(newDtoTasks);
        await prefs.setBool(hasLocalChangesKey, false);
        return null;
      } else {
        //if (hasUnsyncLocalChanges && localRevision != serverRevision)
        //Wake the f up samurai, we have a conflict to resolve!
        //Get last server revision time (if no value is stored, it is null)
        logger.i(
          'Server has new data, database has new data, resolving the merge conflict',
        );
        final lastServerRevisionTimeInMillisec =
            prefs.getInt(lastServerRevisionTimeKey);
        final DateTime? lastServerRevisionTime =
            lastServerRevisionTimeInMillisec == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(
                    lastServerRevisionTimeInMillisec,
                  );
        //Get the map of database tasks {task_id: domain_task}
        final dbTasks = await db.getTasksList();
        final dbTasksMap = {
          for (final dbTask in dbTasks) dbTask.uuid: dbTask.toDomain()
        };
        //Get the map of server tasks {task_id: domain_task}
        final serverTasksMap = {
          for (final serverTask in serverTasks.list)
            serverTask.id: serverTask.toDomain()
        };
        //This will store merge result
        final List<TaskModel> tasksList = [];
        //Go through all database tasks
        for (final taskFromDB in dbTasksMap.entries) {
          //Check if task exists in both maps
          if (serverTasksMap.containsKey(taskFromDB.key)) {
            if (lastServerRevisionTime == null ||
                taskFromDB.value.changedAt.isAfter(lastServerRevisionTime)) {
              //If it is the first launch or task has local changes after revision, take task from db
              tasksList.add(taskFromDB.value);
            } else {
              //If task has no local changes after last server revision, take task from the server
              tasksList.add(serverTasksMap[taskFromDB.key]!);
            }
            serverTasksMap.remove(taskFromDB.key);
          } else if (lastServerRevisionTime == null ||
              taskFromDB.value.changedAt.isAfter(lastServerRevisionTime)) {
            //If it is the first launch or task has been created/changed after last revision, take task from db
            tasksList.add(taskFromDB.value);
          }
        }
        //Now go through the remaining server tasks
        for (final taskFromServer in serverTasksMap.entries) {
          if (lastServerRevisionTime == null ||
              taskFromServer.value.changedAt.isAfter(lastServerRevisionTime)) {
            //If it is the first launch or task has been created/changed on the server after last revision
            //despite its deletion locally we take it from the server, because it is important for someone
            tasksList.add(taskFromServer.value);
          }
        }
        final newServerTasks = tasksList.map((task) => task.toDto()).toList();
        await server.patchTasks(newServerTasks);
        await prefs.setBool(hasLocalChangesKey, false);
        prioritySort(tasksList);
        return tasksList;
      }
    } on SocketException {
      rethrow;
    } on ServerErrorException {
      rethrow;
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  @override
  Future<void> addDBTask(TaskModel newTask) async {
    final newTaskDB = newTask.toDB();
    await db.addTask(newTaskDB);
  }

  @override
  Future<void> addServerTask(TaskModel newTask) async {
    final newTaskDto = newTask.toDto();
    try {
      await server.addTask(newTaskDto);
    } on SocketException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } on UnsynchronizedDataException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } on ServerErrorException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } catch (error) {
      logger.e(error);
    }
  }

  @override
  Future<void> updateDBTask(String id, TaskModel newTask) async {
    final newTaskDB = newTask.toDB();
    await db.updateTask(id, newTaskDB);
  }

  @override
  Future<void> updateServerTask(String id, TaskModel newTask) async {
    final newTaskDto = newTask.toDto();
    try {
      await server.updateTask(id, newTaskDto);
    } on SocketException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } on UnsynchronizedDataException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } on ServerErrorException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } catch (error) {
      logger.e(error);
    }
  }

  @override
  Future<void> removeDBTask(String id) async {
    await db.removeTask(id);
  }

  @override
  Future<void> removeServerTask(String id) async {
    try {
      await server.removeTask(id);
    } on SocketException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } on UnsynchronizedDataException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } on ServerErrorException {
      prefs.setBool(hasLocalChangesKey, true);
      rethrow;
    } catch (error) {
      logger.e(error);
    }
  }

  void prioritySort(List<TaskModel> tasks) {
    tasks.sort(
      (a, b) {
        final compare = a.priority.index.compareTo(b.priority.index);
        if (compare == 0) {
          return b.createdAt.compareTo(a.createdAt);
        }
        return compare;
      },
    );
  }
}
