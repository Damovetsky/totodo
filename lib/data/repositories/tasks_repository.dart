import '../databases/task_server_db.dart';
import '../models/task.dart';

abstract interface class TasksRepository {
  Future<List<Task>> getTasks();

  Future<void> addTask(Task task);

  Future<void> updateTask(String id, Task task);

  Future<void> removeTask(String id);

  Future<void> toggleTask(String id);

  Future<void> patchTasks(List<Task> tasks);
}

class TasksRepositoryImpl implements TasksRepository {
  //TODO organize di
  final serverDB = TaskServerDBImpl();

  //TODO get revision on repository init
  late int _revision;

  @override
  Future<void> addTask(Task newTask) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks() async {
    final serverResponse = await serverDB.getTasksList();
    _revision = serverResponse['revision'];
    final mapList = serverResponse['list'] as List<Map<String, dynamic>>;
    final tasksList =
        mapList.map((jsonTask) => Task.fromJson(jsonTask)).toList();
    return tasksList;
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
