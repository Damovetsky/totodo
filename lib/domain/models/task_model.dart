import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String description,
    required bool isChecked,
    required Priority priority,
    DateTime? dueDate,
    String? color,
    required DateTime createdAt,
    required DateTime changedAt,
    required String deviceId,
  }) = _TaskModel;
}

//It is important to keep the correct order of items here (for sorting)
enum Priority {
  high,
  none,
  low,
}
