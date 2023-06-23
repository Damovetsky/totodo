import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@JsonSerializable(constructor: '_')
class Task {
  final String id;

  @JsonKey(name: 'text')
  final String description;

  @JsonKey(
    name: 'created_at',
    fromJson: _dateTimeFromEpoch,
    toJson: _dateTimeToEpoch,
  )
  final DateTime createdAt;

  @JsonKey(
    name: 'deadline',
    fromJson: _dateTimeFromEpochWithNull,
    toJson: _dateTimeToEpochWithNull,
  )
  final DateTime? dueDate;

  @JsonKey(
    name: 'changed_at',
    fromJson: _dateTimeFromEpoch,
    toJson: _dateTimeToEpoch,
  )
  final DateTime changedAt;

  @JsonKey(name: 'importance')
  final Priority priority;

  @JsonKey(
    fromJson: _colorFromString,
    toJson: _colorToString,
  )
  final Color? color;

  @JsonKey(name: 'last_updated_by')
  final String deviceId;

  @JsonKey(name: 'done')
  final bool isChecked;

  //Constructor for JsonSerializable
  Task._({
    required this.id,
    required this.description,
    required this.changedAt,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
    required this.isChecked,
    required this.deviceId,
    required this.color,
  });

  Task({
    required this.description,
    required this.createdAt,
    this.color,
    this.dueDate,
    this.priority = Priority.none,
    this.isChecked = false,
    //TODO: implement device id logic
  })  : id = const Uuid().v4(),
        changedAt = DateTime.now(),
        deviceId = 'unknown';

  Task.withId({
    required this.id,
    required this.description,
    required this.createdAt,
    this.color,
    this.dueDate,
    this.priority = Priority.none,
    this.isChecked = false,
  })  : changedAt = DateTime.now(),
        deviceId = 'unknown';

  static DateTime _dateTimeFromEpoch(int ms) =>
      DateTime.fromMicrosecondsSinceEpoch(ms);

  static int _dateTimeToEpoch(DateTime dateTime) =>
      dateTime.microsecondsSinceEpoch;

  static DateTime? _dateTimeFromEpochWithNull(int? ms) {
    return ms == null ? null : DateTime?.fromMicrosecondsSinceEpoch(ms);
  }

  static int? _dateTimeToEpochWithNull(DateTime? dateTime) {
    return dateTime?.microsecondsSinceEpoch;
  }

  static String? _colorToString(Color? color) {
    return color?.value.toRadixString(16);
  }

  static Color? _colorFromString(String? strColor) {
    return strColor == null ? null : Color(int.parse(strColor, radix: 16));
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? description,
    DateTime? changedAt,
    Priority? priority,
    DateTime? dueDate,
    DateTime? createdAt,
    bool? isChecked,
    String? deviceId,
    Color? color,
  }) {
    return Task._(
      id: id ?? this.id,
      description: description ?? this.description,
      changedAt: changedAt ?? this.changedAt,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      isChecked: isChecked ?? this.isChecked,
      deviceId: deviceId ?? this.deviceId,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'id: $id, description: $description, dueDate: $dueDate, isChecked: $isChecked, Priority: $priority, createdAt: $createdAt, changedAt: $changedAt, deviceId: $deviceId, color: $color';
  }
}

enum Priority {
  @JsonValue('basic')
  none,
  @JsonValue('important')
  high,
  @JsonValue('low')
  low,
}
