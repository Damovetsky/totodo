import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exeption.dart';
import '../../domain/models/task_model.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../../logger.dart';

@lazySingleton
class Tasks with ChangeNotifier {
  final TasksRepository tasksRepos;
  Tasks(this.tasksRepos);

  List<TaskModel> _tasks = [
    // Task(
    //   description: 'Приветствую тебя на экране с задачами моего приложения!',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Ты скорее всего хочешь проверить реализованный функционал',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Эту задачу можно свайпнуть вправо, чтобы её выполнить',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'А эту задачу можно удалить свайпом влево',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description:
    //       'А это просто задача с ну ооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооочень длинным текстом',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description:
    //       'Когда повыполняешь задачи, нажми на иконку глаза, чтобы скрыть выполненные',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'А это просто крайне срочная задача!',
    //   priority: Priority.high,
    //   createdAt: DateTime.now(),
    //   dueDate: DateTime.now(),
    // ),
    // Task(
    //   description: 'Эту задачу можно отредактировать нажав на иконку -->',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //     description:
    //         'Тут уж совсем несрочная задача, дедлайн которой ещё не скоро',
    //     createdAt: DateTime.now(),
    //     dueDate: DateTime(2024),
    //     priority: Priority.low),
    // Task(
    //   description: 'Попробуй добавить новую задачу при помощи кнопки с плюсом',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description:
    //       'Дальше просто лист задач, чтобы была возможность проверить скрол',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Задача 1',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Задача 2',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Задача 3',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Задача 4',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Задача 5',
    //   createdAt: DateTime.now(),
    // ),
    // Task(
    //   description: 'Удачной проверки и успехов во Flutter!',
    //   createdAt: DateTime.now(),
    // ),
  ];

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
      } on SocketException {
        _dataStatus = DataStatus.unsync;
        notifyListeners();
      } on UnsynchronizedDataException {
        _dataStatus = DataStatus.unsync;
        notifyListeners();
      }
    } else {
      logger.e('Task index was not found when checking the checkbox');
    }
  }

  Future<void> removeTask(String id) async {
    try {
      final task = _tasks.firstWhere((element) => element.id == id);
      _tasks.remove(task);
      notifyListeners();
      await tasksRepos.removeDBTask(id);
      try {
        await tasksRepos.removeServerTask(id);
      } on SocketException {
        _dataStatus = DataStatus.unsync;
        notifyListeners();
      } on UnsynchronizedDataException {
        _dataStatus = DataStatus.unsync;
        notifyListeners();
      }
    } catch (error) {
      logger.e(error);
      logger.e('Task was not found when removing it');
    }
  }

  Future<void> updateTask(String id, TaskModel newTask) async {
    //change task in the list based on new priority
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      if (_tasks[taskIndex].priority == newTask.priority) {
        _tasks[taskIndex] == newTask;
      } else if (_tasks[taskIndex].priority.index < newTask.priority.index) {
        _tasks.removeAt(taskIndex);
        final newIndex = _tasks.indexWhere(
          (task) => task.priority.index >= newTask.priority.index,
        );
        newIndex == -1 ? _tasks.add(newTask) : _tasks.insert(newIndex, newTask);
      } else {
        _tasks.removeAt(taskIndex);
        final newIndex = _tasks.lastIndexWhere(
          (task) => task.priority.index <= newTask.priority.index,
        );
        newIndex == -1
            ? _tasks.insert(0, newTask)
            : _tasks.insert(newIndex + 1, newTask);
      }
      notifyListeners();
      await tasksRepos.updateDBTask(id, newTask);
      try {
        await tasksRepos.updateServerTask(id, newTask);
      } on SocketException {
        _dataStatus = DataStatus.unsync;
        notifyListeners();
      } on UnsynchronizedDataException {
        _dataStatus = DataStatus.unsync;
        notifyListeners();
      }
    } else {
      logger.e('Task was not found when updating it');
    }
  }

  Future<void> addTask(TaskModel newTask) async {
    //put new task in the list based on its priority
    if (newTask.priority == Priority.high) {
      _tasks.insert(0, newTask);
    } else if (newTask.priority == Priority.none) {
      final index = _tasks.indexWhere((task) => task.priority == Priority.none);
      if (index == -1) {
        final anotherIndex =
            _tasks.indexWhere((task) => task.priority == Priority.low);
        anotherIndex == -1
            ? _tasks.add(newTask)
            : _tasks.insert(anotherIndex, newTask);
      } else {
        _tasks.insert(index, newTask);
      }
    } else {
      final index = _tasks.indexWhere((task) => task.priority == Priority.low);
      if (index == -1) {
        _tasks.add(newTask);
      } else {
        _tasks.insert(index, newTask);
      }
    }

    notifyListeners();
    await tasksRepos.addDBTask(newTask);
    logger.i('New task added: $newTask');
    try {
      await tasksRepos.addServerTask(newTask);
    } on SocketException {
      _dataStatus = DataStatus.unsync;
      notifyListeners();
    } on UnsynchronizedDataException {
      _dataStatus = DataStatus.unsync;
      notifyListeners();
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
