import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exeption.dart';
import '../../data/services/analitics/analitics.dart';
import '../../domain/models/task_model.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../../logger.dart';
import '../screens/my_tasks_screen/widgets/task_tile.dart';

@lazySingleton
class Tasks with ChangeNotifier {
  final TasksRepository tasksRepos;
  final Analytics analitics;
  Tasks(this.tasksRepos, this.analitics);

  List<TaskModel> _tasks = [];

  late final GlobalKey<AnimatedListState> _listKey;

  void setListKey(GlobalKey<AnimatedListState> key) {
    _listKey = key;
  }

  DataStatus _dataStatus = DataStatus.unsync;

  DataStatus get dataStatus {
    return _dataStatus;
  }

  int getCompletedTaskCount() {
    int count = 0;
    for (final element in _tasks) {
      if (element.isChecked == true) {
        count++;
      }
    }
    return count;
  }

  bool _showCompleted = true;

  List<TaskModel> get tasks {
    return [..._tasks];
  }

  bool get showCompleted {
    return _showCompleted;
  }

  Future<void> fetchAndSetTasks() async {
    _tasks = await tasksRepos.getDBTasks();
    _dataStatus = DataStatus.loading;
    notifyListeners();
    try {
      final newTasks = await tasksRepos.getServerTasks();
      if (newTasks != null) {
        _tasks = newTasks;
      }
      _dataStatus = DataStatus.sync;
    } on SocketException {
      _dataStatus = DataStatus.unsync;
    } on ServerErrorException {
      _dataStatus = DataStatus.unsync;
    }
    notifyListeners();
  }

  void toggleTask(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final status = _tasks[index].isChecked;
      _tasks[index] =
          _tasks[index].copyWith(isChecked: !status, changedAt: DateTime.now());
      notifyListeners();
      await tasksRepos.updateDBTask(id, _tasks[index]);
      try {
        await tasksRepos.updateServerTask(id, _tasks[index]);
        analitics.toggleTaskEvent(_tasks[index], true);
      } catch (e) {
        if (e is SocketException ||
            e is UnsynchronizedDataException ||
            e is ServerErrorException) {
          _dataStatus = DataStatus.unsync;
          notifyListeners();
          analitics.toggleTaskEvent(_tasks[index], false);
        } else {
          rethrow;
        }
      }
    } else {
      logger.e('Task index was not found when checking the checkbox');
    }
  }

  Future<void> removeTask(String id) async {
    try {
      final index = _tasks.indexWhere((element) => element.id == id);
      final task = _tasks[index];
      _listKey.currentState
          ?.removeItem(index, (context, animation) => Container());
      _tasks.remove(task);
      notifyListeners();
      await tasksRepos.removeDBTask(id);
      try {
        await tasksRepos.removeServerTask(id);
        analitics.removeTaskEvent(task, true);
      } catch (e) {
        if (e is SocketException ||
            e is UnsynchronizedDataException ||
            e is ServerErrorException) {
          _dataStatus = DataStatus.unsync;
          notifyListeners();
          analitics.removeTaskEvent(task, false);
        } else {
          rethrow;
        }
      }
    } catch (error) {
      logger.e('Task was not found when removing it');
    }
  }

  Future<void> updateTask(String id, TaskModel newTask) async {
    //change task in the list based on new priority
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final oldTask = _tasks[taskIndex];
      _listKey.currentState?.removeItem(
        duration: const Duration(milliseconds: 600),
        taskIndex,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: TaskTile(task: oldTask),
        ),
      );
      if (_tasks[taskIndex].priority == newTask.priority) {
        _tasks[taskIndex] = newTask;
        _listKey.currentState?.insertItem(
          taskIndex,
          duration: const Duration(milliseconds: 600),
        );
      } else if (_tasks[taskIndex].priority.index < newTask.priority.index) {
        _tasks.removeAt(taskIndex);
        final newIndex = _tasks.indexWhere(
          (task) => task.priority.index >= newTask.priority.index,
        );
        if (newIndex == -1) {
          _tasks.add(newTask);
          _listKey.currentState?.insertItem(
            _tasks.length - 1,
            duration: const Duration(milliseconds: 600),
          );
        } else {
          _tasks.insert(newIndex, newTask);
          _listKey.currentState?.insertItem(
            newIndex,
            duration: const Duration(milliseconds: 600),
          );
        }
      } else {
        _tasks.removeAt(taskIndex);
        final newIndex = _tasks.lastIndexWhere(
          (task) => task.priority.index <= newTask.priority.index,
        );
        if (newIndex == -1) {
          _tasks.insert(0, newTask);
          _listKey.currentState?.insertItem(
            0,
            duration: const Duration(milliseconds: 600),
          );
        } else {
          _tasks.insert(newIndex + 1, newTask);
          _listKey.currentState?.insertItem(
            newIndex + 1,
            duration: const Duration(milliseconds: 600),
          );
        }
      }
      notifyListeners();
      await tasksRepos.updateDBTask(id, newTask);
      try {
        await tasksRepos.updateServerTask(id, newTask);
        analitics.editTaskEvent(newTask, true);
      } catch (e) {
        if (e is SocketException ||
            e is UnsynchronizedDataException ||
            e is ServerErrorException) {
          _dataStatus = DataStatus.unsync;
          notifyListeners();
          analitics.editTaskEvent(newTask, false);
        } else {
          rethrow;
        }
      }
    } else {
      logger.e('Task was not found when updating it');
    }
  }

  Future<void> addTask(TaskModel newTask) async {
    //put new task in the list based on its priority
    if (newTask.priority == Priority.high) {
      _tasks.insert(0, newTask);
      _listKey.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 500));
    } else if (newTask.priority == Priority.none) {
      final index = _tasks.indexWhere((task) => task.priority == Priority.none);
      if (index == -1) {
        final anotherIndex =
            _tasks.indexWhere((task) => task.priority == Priority.low);
        if (anotherIndex == -1) {
          _tasks.add(newTask);
          _listKey.currentState?.insertItem(
            _tasks.length - 1,
            duration: const Duration(milliseconds: 500),
          );
        } else {
          _tasks.insert(anotherIndex, newTask);
          _listKey.currentState?.insertItem(
            anotherIndex,
            duration: const Duration(milliseconds: 500),
          );
        }
      } else {
        _tasks.insert(index, newTask);
        _listKey.currentState
            ?.insertItem(index, duration: const Duration(milliseconds: 500));
      }
    } else {
      final index = _tasks.indexWhere((task) => task.priority == Priority.low);
      if (index == -1) {
        _tasks.add(newTask);
        _listKey.currentState?.insertItem(
          _tasks.length - 1,
          duration: const Duration(milliseconds: 500),
        );
      } else {
        _tasks.insert(index, newTask);
        _listKey.currentState?.insertItem(
          index,
          duration: const Duration(milliseconds: 500),
        );
      }
    }

    notifyListeners();
    await tasksRepos.addDBTask(newTask);
    logger.i('New task added: $newTask');
    try {
      await tasksRepos.addServerTask(newTask);
      analitics.addTaskEvent(newTask, true);
    } catch (e) {
      if (e is SocketException ||
          e is UnsynchronizedDataException ||
          e is ServerErrorException) {
        _dataStatus = DataStatus.unsync;
        notifyListeners();
        analitics.addTaskEvent(newTask, false);
      } else {
        rethrow;
      }
    }
  }

  bool toggleCompletedTasksVisibility() {
    _showCompleted = !_showCompleted;
    notifyListeners();
    return _showCompleted;
  }
}

enum DataStatus {
  sync,
  loading,
  unsync,
}
