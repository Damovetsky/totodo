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
      description: 'Learn a new language',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'g',
      description: 'Try a new recipe',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'h',
      description: 'Organize your closet',
      createdAt: DateTime.now(),
    ),
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
      description: 'Learn a new language',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'g',
      description: 'Try a new recipe',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 'h',
      description: 'Organize your closet',
      createdAt: DateTime.now(),
    ),
  ];

  Tasks();

  List<Task> get tasks {
    return [..._tasks];
  }

  void toggleTask(int index) {
    _tasks[index].isChecked = !_tasks[index].isChecked;
  }
}
