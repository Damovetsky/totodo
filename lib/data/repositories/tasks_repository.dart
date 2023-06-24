import '../databases/task_db.dart';
import '../databases/task_server.dart';
import '../models/task.dart';

abstract interface class TasksRepository {
  Future<List<Task>> getTasks();

  Future<void> addTask(Task task);

  Future<void> updateTask(String id, Task task);

  Future<void> removeTask(String id);

  Future<void> patchTasks(List<Task> tasks);
}

class TasksRepositoryImpl implements TasksRepository {
  //TODO organize di
  final TaskServer server = TaskServerImpl();
  final TaskDB db = IsarService();

  late int _revision;

  @override
  Future<void> addTask(Task newTask) async {
    await server.addTask(newTask, _revision);
    await db.addTask(newTask, _revision);
    _revision++;
  }

  @override
  Future<List<Task>> getTasks() async {
    final serverResponse = await server.getTasksList();
    _revision = serverResponse['revision'];
    final mapList = serverResponse['list'] as List;
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
  Future<void> removeTask(String id) async {
    await server.removeTask(id, _revision);
    await db.removeTask(id, _revision);
    _revision++;
  }

  @override
  Future<void> updateTask(String id, Task newTask) async {
    await server.updateTask(id, newTask, _revision);
    await db.updateTask(id, newTask, _revision);
    _revision++;
  }
}
