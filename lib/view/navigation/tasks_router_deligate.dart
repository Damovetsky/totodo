import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/task_model.dart';
import '../screens/my_tasks_screen/my_tasks_screen.dart';
import '../screens/task_screen/task_detail_screen.dart';
import '../screens/unknown_screen/unknown_screen.dart';
import 'navigation_state.dart';

@lazySingleton
class TasksRouterDeligate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  TasksRouterDeligate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(
          child: MyTasksScreen(),
        ),
        if (state?.isNewTaskScreen == true)
          const MaterialPage(
            child: TaskDetailScreen(),
          ),
        if (state?.isTaskEditScreen == true)
          MaterialPage(
            child: TaskDetailScreen(
              task: state?.selectedTask,
            ),
          ),
        if (state?.isUnknown == true)
          const MaterialPage(
            child: UnknownScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        state = NavigationState.root();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }

  void showNewTaskScreen() {
    state = NavigationState.newTask();
    notifyListeners();
  }

  void showTaskEditingScreen(TaskModel task) {
    state = NavigationState.editTask(task);
    notifyListeners();
  }
}
