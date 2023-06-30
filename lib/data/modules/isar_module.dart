import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../services/tasks_db/task_db_model/task_db.dart';

@module
abstract class IsarModule {
  @preResolve
  Future<Isar> get isar async => Isar.open(
        [TaskDBSchema],
        directory: (await getApplicationDocumentsDirectory()).path,
        inspector: true,
      );
}
