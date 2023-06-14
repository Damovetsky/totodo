import 'package:flutter/material.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: 'a',
      description: 'Go for a walk',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'b',
      description: 'Read a book',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'c',
      description: 'Clean the house',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'd',
      description: 'Write a poem',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'e',
      description: 'Call a friend',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'f',
      description: 'Learn a new word',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'g',
      description: 'Try a new recipe',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'h',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis nisl congue, faucibus urna congue, dictum velit. Integer non tempus tortor. Nulla volutpat commodo velit, sit amet euismod magna sodales ac. Aliquam pretium convallis magna sed vestibulum. Vestibulum ornare varius posuere. Phasellus congue sodales justo, ut aliquam nibh fermentum et. Vivamus pulvinar gravida nisl non dapibus. Nulla scelerisque ullamcorper magna sit amet fermentum. Nullam nec rutrum tortor.',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'i',
      description: 'Go for a walk',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'j',
      description: 'Read a book',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'k',
      description: 'Clean the house',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'm',
      description: 'Write a poem',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'n',
      description: 'Call a friend',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'p',
      description: 'Learn a new language',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'o',
      description: 'Try a new recipe',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 's',
      description: 'Organize your closet',
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
    _tasks[index].isChecked = !_tasks[index].isChecked;
    if (_tasks[index].isChecked) {
      _completedTaskCount++;
    } else {
      _completedTaskCount--;
    }
    notifyListeners();
  }

  void removeTask(String id) {
    final task = _tasks.firstWhere((element) => element.id == id);
    if (task.isChecked) {
      _completedTaskCount--;
    }
    _tasks.remove(task);
    notifyListeners();
  }

  bool toggleCompletedTasksVisibility() {
    _showCompleted = !_showCompleted;
    notifyListeners();
    return _showCompleted;
  }
}
