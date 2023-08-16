import '../../domain/models/task_model.dart';
import '../services/tasks_server/dto/task_dto.dart';

/// Converts [TaskDto] в [TaskModel]
extension TaskFromDtoToDomain on TaskDto {
  TaskModel toDomain() {
    return TaskModel(
      id: id,
      description: text,
      isChecked: done,
      priority: toDomainPriority(importance),
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

Priority toDomainPriority(Importance importance) {
  switch (importance) {
    case Importance.low:
      return Priority.low;
    case Importance.basic:
      return Priority.none;
    case Importance.important:
      return Priority.high;
  }
}

/// Преобразовываем [TaskModel] в [TaskDto]
extension TaskFromDomainToDto on TaskModel {
  TaskDto toDto() {
    return TaskDto(
      id: id,
      text: description,
      done: isChecked,
      importance: toDtoImportance(priority),
      deadline: dueDate?.millisecondsSinceEpoch,
      color: color,
      createdAt: createdAt.millisecondsSinceEpoch,
      changedAt: changedAt.millisecondsSinceEpoch,
      lastUpdatedBy: deviceId,
    );
  }
}

Importance toDtoImportance(Priority priority) {
  switch (priority) {
    case Priority.low:
      return Importance.low;
    case Priority.none:
      return Importance.basic;
    case Priority.high:
      return Importance.important;
  }
}
