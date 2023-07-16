import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../../../helpers/int_id_from_uuid.dart';

part 'task_db.freezed.dart';
part 'task_db.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class TaskDB with _$TaskDB {
  const TaskDB._();

  const factory TaskDB({
    required String uuid,
    required String title,
    required bool isChecked,
    @enumerated required Priority priority,
    int? deadline,
    String? color,
    required int createdAt,
    required int changedAt,
    required String lastUpdatedBy,
  }) = _TaskDB;

  Id get isarId => IntIdFromUuid.generate(uuid);
}

enum Priority {
  no,
  low,
  high,
}
