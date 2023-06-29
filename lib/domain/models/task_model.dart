import 'package:uuid/uuid.dart';

enum Priority {
  none,
  low,
  high,
}

class TaskModel {
  final String id;
  final String description;
  final bool isChecked;
  final Priority priority;
  final DateTime? dueDate;
  final String? color;
  final DateTime createdAt;
  final DateTime changedAt;
  final String deviceId;

  TaskModel({
    String? id,
    required this.description,
    required this.isChecked,
    required this.priority,
    this.dueDate,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.deviceId,
  }) : id = id ?? const Uuid().v4();

  TaskModel copyWith({
    String? id,
    String? description,
    bool? isChecked,
    Priority? priority,
    DateTime? dueDate,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? deviceId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      isChecked: isChecked ?? this.isChecked,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  String toString() {
    return 'id: $id, description: $description, dueDate: $dueDate, isChecked: $isChecked, Priority: $priority, createdAt: $createdAt, changedAt: $changedAt, deviceId: $deviceId, color: $color';
  }
}
