import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/repositories/tasks_repository.dart';
import '../../logger.dart';
import '../../data/models/task.dart';

class Tasks with ChangeNotifier {
  final TasksRepository tasksRepos = TasksRepositoryImpl();

  List<Task> _tasks = [
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

  List<Task> get tasks {
    return [..._tasks];
  }

  bool get showCompleted {
    return _showCompleted;
  }

  Future<void> fetchAndSetTasks() async {
    _tasks = await tasksRepos.getTasks();
    notifyListeners();
  }

  void toggleTask(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final status = _tasks[index].isChecked;
      _tasks[index] = _tasks[index].copyWith(isChecked: !status);
      await tasksRepos.updateTask(
        id,
        _tasks[index],
      );

      notifyListeners();
    } else {
      logger.e('Task index was not found when checking the checkbox');
    }
  }

  Future<void> removeTask(String id) async {
    try {
      final task = _tasks.firstWhere((element) => element.id == id);
      _tasks.remove(task);
      notifyListeners();
      await tasksRepos.removeTask(id);
    } catch (error) {
      logger.e('Task was not found when removing it');
    }
  }

  Future<void> updateTask(String id, Task newTask) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      if (taskIndex >= 0) {
        _tasks[taskIndex] = newTask;
      }
      notifyListeners();
      await tasksRepos.updateTask(id, newTask);
    } else {
      logger.e('Task was not found when updating it');
    }
  }

  Future<void> addTask(Task newTask) async {
    await tasksRepos.addTask(newTask);
    _tasks.add(newTask);
    notifyListeners();
    logger.i('New task added: $newTask');
  }

  bool toggleCompletedTasksVisibility() {
    _showCompleted = !_showCompleted;
    notifyListeners();
    return _showCompleted;
  }
}
