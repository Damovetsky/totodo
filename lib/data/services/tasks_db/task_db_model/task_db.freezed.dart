// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_db.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskDB {
  String get uuid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;
  @enumerated
  Priority get priority => throw _privateConstructorUsedError;
  int? get deadline => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int get createdAt => throw _privateConstructorUsedError;
  int get changedAt => throw _privateConstructorUsedError;
  String get lastUpdatedBy => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskDBCopyWith<TaskDB> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDBCopyWith<$Res> {
  factory $TaskDBCopyWith(TaskDB value, $Res Function(TaskDB) then) =
      _$TaskDBCopyWithImpl<$Res, TaskDB>;
  @useResult
  $Res call(
      {String uuid,
      String title,
      bool isChecked,
      @enumerated Priority priority,
      int? deadline,
      String? color,
      int createdAt,
      int changedAt,
      String lastUpdatedBy});
}

/// @nodoc
class _$TaskDBCopyWithImpl<$Res, $Val extends TaskDB>
    implements $TaskDBCopyWith<$Res> {
  _$TaskDBCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? title = null,
    Object? isChecked = null,
    Object? priority = null,
    Object? deadline = freezed,
    Object? color = freezed,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Priority,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskDBCopyWith<$Res> implements $TaskDBCopyWith<$Res> {
  factory _$$_TaskDBCopyWith(_$_TaskDB value, $Res Function(_$_TaskDB) then) =
      __$$_TaskDBCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      String title,
      bool isChecked,
      @enumerated Priority priority,
      int? deadline,
      String? color,
      int createdAt,
      int changedAt,
      String lastUpdatedBy});
}

/// @nodoc
class __$$_TaskDBCopyWithImpl<$Res>
    extends _$TaskDBCopyWithImpl<$Res, _$_TaskDB>
    implements _$$_TaskDBCopyWith<$Res> {
  __$$_TaskDBCopyWithImpl(_$_TaskDB _value, $Res Function(_$_TaskDB) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? title = null,
    Object? isChecked = null,
    Object? priority = null,
    Object? deadline = freezed,
    Object? color = freezed,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_$_TaskDB(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Priority,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TaskDB extends _TaskDB {
  const _$_TaskDB(
      {required this.uuid,
      required this.title,
      required this.isChecked,
      @enumerated required this.priority,
      this.deadline,
      this.color,
      required this.createdAt,
      required this.changedAt,
      required this.lastUpdatedBy})
      : super._();

  @override
  final String uuid;
  @override
  final String title;
  @override
  final bool isChecked;
  @override
  @enumerated
  final Priority priority;
  @override
  final int? deadline;
  @override
  final String? color;
  @override
  final int createdAt;
  @override
  final int changedAt;
  @override
  final String lastUpdatedBy;

  @override
  String toString() {
    return 'TaskDB(uuid: $uuid, title: $title, isChecked: $isChecked, priority: $priority, deadline: $deadline, color: $color, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskDB &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, title, isChecked, priority,
      deadline, color, createdAt, changedAt, lastUpdatedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskDBCopyWith<_$_TaskDB> get copyWith =>
      __$$_TaskDBCopyWithImpl<_$_TaskDB>(this, _$identity);
}

abstract class _TaskDB extends TaskDB {
  const factory _TaskDB(
      {required final String uuid,
      required final String title,
      required final bool isChecked,
      @enumerated required final Priority priority,
      final int? deadline,
      final String? color,
      required final int createdAt,
      required final int changedAt,
      required final String lastUpdatedBy}) = _$_TaskDB;
  const _TaskDB._() : super._();

  @override
  String get uuid;
  @override
  String get title;
  @override
  bool get isChecked;
  @override
  @enumerated
  Priority get priority;
  @override
  int? get deadline;
  @override
  String? get color;
  @override
  int get createdAt;
  @override
  int get changedAt;
  @override
  String get lastUpdatedBy;
  @override
  @JsonKey(ignore: true)
  _$$_TaskDBCopyWith<_$_TaskDB> get copyWith =>
      throw _privateConstructorUsedError;
}
