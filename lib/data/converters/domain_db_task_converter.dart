import '../../domain/models/task_model.dart';
import '../services/tasks_db/task_db_model/task_db.dart' as db;

/// Converts [TaskDB] to [TaskModel]
extension TaskFromDBToDomain on db.TaskDB {
  TaskModel toDomain() {
    return TaskModel(
      id: uuid,
      description: title,
      isChecked: isChecked,
      priority: toDomainPriority(priority),
      dueDate: deadline != null
          ? DateTime.fromMillisecondsSinceEpoch(deadline!)
          : null,
      color: color,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      changedAt: DateTime.fromMillisecondsSinceEpoch(changedAt),
      deviceId: lastUpdatedBy,
    );
  }
}

Priority toDomainPriority(db.Priority priority) {
  switch (priority) {
    case db.Priority.low:
      return Priority.low;
    case db.Priority.no:
      return Priority.none;
    case db.Priority.high:
      return Priority.high;
  }
}

/// Converts [TaskModel] to [TaskDB]
extension TaskFromDomainToDB on TaskModel {
  db.TaskDB toDB() {
    return db.TaskDB(
      uuid: id,
      title: description,
      isChecked: isChecked,
      priority: toDBPriority(priority),
      deadline: dueDate?.millisecondsSinceEpoch,
      color: color,
      createdAt: createdAt.millisecondsSinceEpoch,
      changedAt: changedAt.millisecondsSinceEpoch,
      lastUpdatedBy: deviceId,
    );
  }
}

db.Priority toDBPriority(Priority priority) {
  switch (priority) {
    case Priority.low:
      return db.Priority.low;
    case Priority.none:
      return db.Priority.no;
    case Priority.high:
      return db.Priority.high;
  }
}
