import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'task_db_model/task_db.dart';

abstract interface class TasksDB {
  Future<List<TaskDB>> getTasksList();

  Future<void> addTask(TaskDB newTask);

  Future<void> removeTask(String id);

  Future<void> updateTask(String id, TaskDB newTask);

  Future<void> patchTasks(List<TaskDB> tasks);

  Future<void> getTask(String id);
}

class IsarService implements TasksDB {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  @override
  Future<void> addTask(TaskDB newTask) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.taskDBs.putSync(newTask));
  }

  @override
  Future<void> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<TaskDB>> getTasksList() async {
    final isar = await db;
    return await isar.taskDBs.where().findAll();
  }

  @override
  Future<void> patchTasks(List<TaskDB> tasks) {
    // TODO: implement patchTasks
    throw UnimplementedError();
  }

  @override
  Future<void> removeTask(String id) async {
    final isar = await db;
    isar.writeTxnSync(
      () => isar.taskDBs.filter().uuidEqualTo(id).deleteFirstSync(),
    );
  }

  @override
  Future<void> updateTask(String id, TaskDB newTask) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.taskDBs.putSync(newTask));
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TaskDBSchema],
        directory: (await getApplicationDocumentsDirectory()).path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
