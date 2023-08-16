import 'package:totodo/data/services/tasks_db/task_db_model/task_db.dart';

final List<TaskDB> mockDBTasks = [
  dbTaskA,
  dbTaskB,
];

final List<TaskDB> mockDBTasksWithTasksAC = [
  dbTaskA,
  dbTaskC,
];

const TaskDB dbTaskA = TaskDB(
  uuid: '110ec58a-a0f2-4ac4-8393-c866d813b8da',
  title: 'task a',
  isChecked: true,
  priority: Priority.high,
  createdAt: 1000,
  changedAt: 1001,
  lastUpdatedBy: 'phone',
);
const TaskDB dbTaskB = TaskDB(
  uuid: '110ec58a-a0f2-4ac4-8393-c866d813b8db',
  title: 'task b',
  isChecked: true,
  priority: Priority.high,
  createdAt: 1500,
  changedAt: 1501,
  lastUpdatedBy: 'phone',
);
const TaskDB dbTaskC = TaskDB(
  uuid: '110ec58a-a0f2-4ac4-8393-c866d813b8dc',
  title: 'task c',
  isChecked: true,
  priority: Priority.high,
  createdAt: 1500,
  changedAt: 1501,
  lastUpdatedBy: 'phone',
);
