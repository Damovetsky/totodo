import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import 'task_db_model/task_db.dart';

abstract interface class TasksDB {
  Future<List<TaskDB>> getTasksList();

  Future<void> addTask(TaskDB newTask);

  Future<void> removeTask(String id);

  Future<void> updateTask(String id, TaskDB newTask);

  Future<void> patchTasks(List<TaskDB> tasks);
}

@Injectable(as: TasksDB)
class IsarService implements TasksDB {
  final Isar isar;

  IsarService(this.isar);

  @override
  Future<void> addTask(TaskDB newTask) async {
    isar.writeTxnSync(() => isar.taskDBs.putSync(newTask));
  }

  @override
  Future<List<TaskDB>> getTasksList() async {
    final isarTasks = await isar.taskDBs.where().findAll();
    return isarTasks;
  }

  @override
  Future<void> patchTasks(List<TaskDB> tasks) async {
    isar.writeTxnSync(() {
      isar.taskDBs.clearSync();
      isar.taskDBs.putAllSync(tasks);
    });
  }

  @override
  Future<void> removeTask(String id) async {
    isar.writeTxnSync(
      () => isar.taskDBs.filter().uuidEqualTo(id).deleteFirstSync(),
    );
  }

  @override
  Future<void> updateTask(String id, TaskDB newTask) async {
    isar.writeTxnSync(() => isar.taskDBs.putSync(newTask));
  }
}
