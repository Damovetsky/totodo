// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task._(
      id: json['id'] as String,
      description: json['text'] as String,
      changedAt: Task._dateTimeFromEpoch(json['changed_at'] as int),
      priority: $enumDecode(_$PriorityEnumMap, json['importance']),
      dueDate: Task._dateTimeFromEpochWithNull(json['deadline'] as int?),
      createdAt: Task._dateTimeFromEpoch(json['created_at'] as int),
      isChecked: json['done'] as bool,
      deviceId: json['last_updated_by'] as String,
      color: Task._colorFromString(json['color'] as String?),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.description,
      'created_at': Task._dateTimeToEpoch(instance.createdAt),
      'deadline': Task._dateTimeToEpochWithNull(instance.dueDate),
      'changed_at': Task._dateTimeToEpoch(instance.changedAt),
      'importance': _$PriorityEnumMap[instance.priority]!,
      'color': Task._colorToString(instance.color),
      'last_updated_by': instance.deviceId,
      'done': instance.isChecked,
    };

const _$PriorityEnumMap = {
  Priority.none: 'basic',
  Priority.high: 'important',
  Priority.low: 'low',
};
