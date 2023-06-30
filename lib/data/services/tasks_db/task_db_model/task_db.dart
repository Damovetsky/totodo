import 'package:isar/isar.dart';

import '../../../../helpers/int_id_from_uuid.dart';

part 'task_db.g.dart';

enum Priority {
  no,
  low,
  high,
}

@collection
class TaskDB {
  //???
  Id get isarId => intIdFromUuid.generate(uuid);
  String uuid;
  final String title;
  final bool isChecked;
  @enumerated
  final Priority priority;
  final int? deadline;
  final String? color;
  final int createdAt;
  final int changedAt;
  final String lastUpdatedBy;

  TaskDB({
    required this.uuid,
    required this.title,
    required this.isChecked,
    required this.priority,
    this.deadline,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });
}
