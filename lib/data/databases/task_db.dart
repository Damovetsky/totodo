import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task.dart';

abstract interface class TaskDB {
  Future<List<Task>> getTasksList();

  Future<void> addTask(Task newTask, int revision);

  Future<void> removeTask(String id, int revision);

  Future<void> updateTask(String id, Task newTask, int revision);

  Future<void> patchTasks(List<Task> tasks, int revision);

  Future<void> getTask(String id);
}

class IsarService implements TaskDB {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  @override
  Future<void> addTask(Task newTask, int revision) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.tasks.putSync(newTask));
  }

  @override
  Future<void> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasksList() async {
    final isar = await db;
    return await isar.tasks.where().findAll();
  }

  @override
  Future<void> patchTasks(List<Task> tasks, int revision) {
    // TODO: implement patchTasks
    throw UnimplementedError();
  }

  @override
  Future<void> removeTask(String id, int revision) async {
    final isar = await db;
    isar.writeTxnSync(
      () => isar.tasks.filter().idEqualTo(id).deleteFirstSync(),
    );
  }

  @override
  Future<void> updateTask(String id, Task newTask, int revision) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.tasks.putSync(newTask));
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TaskSchema],
        directory: (await getApplicationDocumentsDirectory()).path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
