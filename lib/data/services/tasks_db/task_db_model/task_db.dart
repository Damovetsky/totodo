import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import '../../../../helpers/int_id_from_uuid.dart';

part 'task_db.g.dart';

enum Priority {
  no,
  low,
  high,
}

@Collection(inheritance: false, ignore: {'props'})
class TaskDB with EquatableMixin {
  Id get isarId => IntIdFromUuid.generate(uuid);
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

  @override
  List<Object?> get props => [uuid];
}
