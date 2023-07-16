import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/di/di.dart';
import '../../domain/routes.dart';
import '../../domain/models/task_model.dart';
import '../providers/tasks.dart';
import 'navigation_state.dart';

@injectable
class TasksRouteInformationParser
    extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final location = routeInformation.location;
    if (location == null) {
      return NavigationState.unknown();
    }

    final uri = Uri.parse(location);

    if (uri.pathSegments.isEmpty) {
      return NavigationState.root();
    }

    if (uri.pathSegments.length == 2) {
      final taskId = uri.pathSegments[1];

      if (uri.pathSegments[0] == Routes.task) {
        try {
          final TaskModel task =
              getIt.get<Tasks>().tasks.firstWhere((task) => task.id == taskId);
          return NavigationState.editTask(task);
        } on StateError {
          return NavigationState.unknown();
        }
      }

      return NavigationState.unknown();
    }

    if (uri.pathSegments.length == 1) {
      final path = uri.pathSegments[0];
      if (path == Routes.newTask) {
        return NavigationState.newTask();
      }

      return NavigationState.root();
    }

    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isNewTaskScreen) {
      return const RouteInformation(location: '/${Routes.newTask}');
    }

    if (configuration.isTaskEditScreen) {
      return RouteInformation(
        location: '/${Routes.task}/${configuration.selectedTask}',
      );
    }

    if (configuration.isUnknown) {
      return null;
    }

    return const RouteInformation(location: '/');
  }
}
