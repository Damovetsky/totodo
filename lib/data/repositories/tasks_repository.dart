import '../models/task.dart';

abstract interface class TasksRepository {
  Future<List<Task>> getTasks();

  Future<void> addTask(Task task);

  Future<void> updateTask(String id, Task task);

  Future<void> removeTask(String id);

  Future<void> toggleTask(String id);

  Future<void> patchTasks(List<Task> tasks);

  Future<int> getCurrentRevision();
}

class TasksRepositoryImpl implements TasksRepository {
  @override
  Future<void> addTask(Task newTask) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<int> getCurrentRevision() {
    // TODO: implement getCurrentRevision
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> patchTasks(List<Task> tasks) {
    // TODO: implement patchTasks
    throw UnimplementedError();
  }

  @override
  Future<void> removeTask(String id) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<void> toggleTask(String id) {
    // TODO: implement toggleTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String id, Task newTask) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
