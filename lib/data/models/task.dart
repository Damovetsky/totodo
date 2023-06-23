import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@collection
@JsonSerializable(constructor: '_forJson', ignoreUnannotated: true)
class Task {
  final Id isarId;

  @JsonKey(name: 'id')
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

  @enumerated
  @JsonKey(name: 'importance')
  final Priority priority;

  @JsonKey(name: 'color')
  final String? color;

  @JsonKey(name: 'last_updated_by')
  final String deviceId;

  @JsonKey(name: 'done')
  final bool isChecked;

  Task._({
    required this.isarId,
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

  //Constructor for JsonSerializable
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
  }) : isarId = isarIdGenerator(id);

  Task({
    required this.id,
    required this.description,
    required this.createdAt,
    this.color,
    this.dueDate,
    this.priority = Priority.none,
    this.isChecked = false,
    //TODO: implement device id logic
  })  : changedAt = DateTime.now(),
        deviceId = 'unknown',
        isarId = isarIdGenerator(id);

  Task.withId({
    required this.id,
    required this.isarId,
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

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    int? isarId,
    String? id,
    String? description,
    DateTime? changedAt,
    Priority? priority,
    DateTime? dueDate,
    DateTime? createdAt,
    bool? isChecked,
    String? deviceId,
    String? color,
  }) {
    return Task._(
      isarId: isarId ?? this.isarId,
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

//Isar needs an id of type int and server of type string,
//so I desided to calculate isarId of string id to get a number up to 16^6
int isarIdGenerator(String id) {
  return int.parse(id.substring(30), radix: 16);
}
