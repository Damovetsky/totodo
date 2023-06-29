import 'package:shared_preferences/shared_preferences.dart';

import '../../data/converters/domain_db_task_converter.dart';
import '../../data/converters/domain_dto_task_converter.dart';
import '../models/task_model.dart';
import '../../data/services/tasks_db/tasks_db.dart';
import '../../data/services/tasks_server/tasks_server.dart';

abstract interface class TasksRepository {
  Future<List<TaskModel>> getTasks();

  Future<void> addTask(TaskModel task);

  Future<void> updateTask(String id, TaskModel task);

  Future<void> removeTask(String id);

  Future<void> patchTasks(List<TaskModel> tasks);
}

class TasksRepositoryImpl implements TasksRepository {
  //TODO organize di
  final SharedPreferences prefs;
  final TasksServer server;
  final TasksDB db;

  TasksRepositoryImpl({
    required this.prefs,
    required this.server,
    required this.db,
  });

  @override
  Future<void> addTask(TaskModel newTask) async {
    final newTaskDto = newTask.toDto();
    final newTaskDB = newTask.toDB();
    await server.addTask(newTaskDto);
    await db.addTask(newTaskDB);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final dtoTasks = await server.getTasksList();
    //_revision = serverResponse['revision'];
    //final mapList = serverResponse['list'] as List;

    final tasksList =
        dtoTasks.list.map((jsonTask) => jsonTask.toDomain()).toList();
    return tasksList;
  }

  @override
  Future<void> patchTasks(List<TaskModel> tasks) {
    // TODO: implement patchTasks
    throw UnimplementedError();
  }

  @override
  Future<void> removeTask(String id) async {
    await server.removeTask(id);
    await db.removeTask(id);
  }

  @override
  Future<void> updateTask(String id, TaskModel newTask) async {
    final newTaskDto = newTask.toDto();
    final newTaskDB = newTask.toDB();
    await server.updateTask(id, newTaskDto);
    await db.updateTask(id, newTaskDB);
  }
}
