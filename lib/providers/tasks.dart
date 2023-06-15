import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  var logger = Logger();

  final List<Task> _tasks = [
    Task(
      id: 'a',
      description: 'Приветствую тебя на экране с задачами моего приложения!',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'b',
      description: 'Ты скорее всего хочешь проверить реализованный функционал',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'c',
      description: 'Эту задачу можно свайпнуть вправо, чтобы её выполнить',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'd',
      description: 'А эту задачу можно удалить свайпом влево',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'e',
      description:
          'А это просто задача с ну ооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооочень длинным текстом',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'f',
      description:
          'Когда повыполняешь задачи, нажми на иконку глаза, чтобы скрыть выполненные',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'g',
      description: 'А это просто крайне срочная задача!',
      priority: Priority.high,
      createdAt: DateTime.now(),
      dueDate: DateTime.now(),
    ),
    Task(
      id: 'h',
      description: 'Эту задачу можно отредактировать нажав на иконку -->',
      createdAt: DateTime.now(),
    ),
    Task(
        id: 'i',
        description:
            'Тут уж совсем несрочная задача, дедлайн которой ещё не скоро',
        createdAt: DateTime.now(),
        dueDate: DateTime(2024),
        priority: Priority.low),
    Task(
      id: 'j',
      description: 'Попробуй добавить новую задачу при помощи кнопки с плюсом',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'k',
      description:
          'Дальше просто лист задач, чтобы была возможность проверить скрол',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'm',
      description: 'Задача 1',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'n',
      description: 'Задача 2',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'p',
      description: 'Задача 3',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'o',
      description: 'Задача 4',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 's',
      description: 'Задача 5',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'l',
      description: 'Удачной проверки и успехов во Flutter!',
      createdAt: DateTime.now(),
    ),
  ];

  int _completedTaskCount = 0;

  bool _showCompleted = true;

  Tasks();

  List<Task> get tasks {
    return [..._tasks];
  }

  int get completedTaskCount {
    return _completedTaskCount;
  }

  bool get showCompleted {
    return _showCompleted;
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isChecked = !_tasks[index].isChecked;
      if (_tasks[index].isChecked) {
        _completedTaskCount++;
      } else {
        _completedTaskCount--;
      }
      notifyListeners();
    } else {
      logger.e('Task index was not found when checking the checkbox');
    }
  }

  void removeTask(String id) {
    try {
      final task = _tasks.firstWhere((element) => element.id == id);
      if (task.isChecked) {
        _completedTaskCount--;
      }
      _tasks.remove(task);
      notifyListeners();
    } catch (error) {
      logger.e('Task was not found when removing it');
    }
  }

  void updateTask(String id, Task newTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      if (taskIndex >= 0) {
        _tasks[taskIndex] = newTask;
      }
      notifyListeners();
    } else {
      logger.e('Task was not found when updating it');
    }
  }

  void addTask(Task newTask) {
    _tasks.insert(0, newTask);
    notifyListeners();
  }

  bool toggleCompletedTasksVisibility() {
    _showCompleted = !_showCompleted;
    notifyListeners();
    return _showCompleted;
  }
}
