import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/task_model.dart';

abstract interface class Analytics {
  void addTaskEvent(TaskModel newTask, bool isOnline);

  void removeTaskEvent(TaskModel task, bool isOnline);

  void editTaskEvent(TaskModel newTask, bool isOnline);

  void toggleTaskEvent(TaskModel task, bool isOnline);

  void navigateToAddTaskScreenEvent();

  void navigateToEditTaskScreenEvent();
}

@Injectable(as: Analytics)
class AnaliticsService implements Analytics {
  final FirebaseAnalytics analytics;

  AnaliticsService(this.analytics);

  @override
  void addTaskEvent(TaskModel newTask, bool isOnline) {
    unawaited(
      analytics.logEvent(
        name: 'task_added',
        parameters: {
          'importance': newTask.priority.name,
          'deadline': newTask.dueDate?.toIso8601String() ?? 'not set',
          'created_at': newTask.createdAt.toIso8601String(),
          'created_online': isOnline ? 'true' : 'false',
        },
      ),
    );
  }

  @override
  void toggleTaskEvent(TaskModel task, bool isOnline) {
    unawaited(
      analytics.logEvent(
        name: 'task_toggled',
        parameters: {
          'state': task.isChecked ? 'checked' : 'unchecked',
          'toggled_online': isOnline ? 'true' : 'false',
        },
      ),
    );
  }

  @override
  void editTaskEvent(TaskModel newTask, bool isOnline) {
    unawaited(
      analytics.logEvent(
        name: 'task_edited',
        parameters: {
          'edited_online': isOnline ? 'true' : 'false',
        },
      ),
    );
  }

  @override
  void removeTaskEvent(TaskModel task, bool isOnline) {
    unawaited(
      analytics.logEvent(
        name: 'task_removed',
        parameters: {
          'was_completed': task.isChecked ? 'true' : 'false',
          'removed_online': isOnline ? 'true' : 'false',
        },
      ),
    );
  }

  @override
  void navigateToAddTaskScreenEvent() {
    unawaited(
      analytics.logEvent(
        name: 'navigated_add_task',
      ),
    );
  }

  @override
  void navigateToEditTaskScreenEvent() {
    unawaited(
      analytics.logEvent(
        name: 'navigated_edit_task',
      ),
    );
  }
}
