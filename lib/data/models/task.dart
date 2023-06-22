import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@JsonSerializable(constructor: '_forJson')
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

  final Priority priority;

  @JsonKey(
    fromJson: _colorFromString,
    toJson: _colorToString,
  )
  final Color? color;

  @JsonKey(name: 'last_updated_by')
  final String deviceId;

  @JsonKey(name: 'done')
  bool isChecked;

  Task._forJson({
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

  @override
  String toString() {
    return 'description: $description, dueDate: $dueDate, isChecked: $isChecked, Priority: $priority';
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
