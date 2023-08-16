import '../../domain/models/task_model.dart';

class NavigationState {
  final bool? _unknown;
  final bool? _newTask;

  TaskModel? selectedTask;

  bool get isNewTaskScreen => _newTask == true;

  bool get isTaskEditScreen => selectedTask != null;

  bool get isRoot => !isNewTaskScreen && !isTaskEditScreen && !isUnknown;

  bool get isUnknown => _unknown == true;

  NavigationState.root()
      : _newTask = false,
        _unknown = false,
        selectedTask = null;

  NavigationState.newTask()
      : _newTask = true,
        _unknown = false,
        selectedTask = null;

  NavigationState.editTask(this.selectedTask)
      : _newTask = false,
        _unknown = false;

  NavigationState.unknown()
      : _unknown = true,
        _newTask = false,
        selectedTask = null;
}
