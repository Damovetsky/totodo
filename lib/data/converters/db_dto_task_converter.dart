import '../services/tasks_db/task_db_model/task_db.dart';
import '../services/tasks_server/dto/task_dto.dart';

/// Converts [TaskDB] to [TaskDto]
extension TaskFromDBToDto on TaskDB {
  TaskDto toDto() {
    return TaskDto(
      id: uuid,
      text: title,
      done: isChecked,
      importance: toDtoImportance(priority),
      deadline: deadline,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}

Importance toDtoImportance(Priority priority) {
  switch (priority) {
    case Priority.low:
      return Importance.low;
    case Priority.no:
      return Importance.basic;
    case Priority.high:
      return Importance.important;
  }
}

/// Converts [TaskDto] to [TaskDB]
extension TaskFromDtoToDB on TaskDto {
  TaskDB toDB() {
    return TaskDB(
      uuid: id,
      title: text,
      isChecked: done,
      priority: toDBPriority(importance),
      deadline: deadline,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}

Priority toDBPriority(Importance importance) {
  switch (importance) {
    case Importance.low:
      return Priority.low;
    case Importance.basic:
      return Priority.no;
    case Importance.important:
      return Priority.high;
  }
}
