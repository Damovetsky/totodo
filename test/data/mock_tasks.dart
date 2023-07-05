import 'package:totodo/domain/models/task_model.dart';

final List<TaskModel> mockTasks = [
  taskB,
  taskA,
];

final List<TaskModel> mockMergedTasks = [
  taskC,
  taskB,
  taskA,
];

final TaskModel taskA = TaskModel(
  description: 'task a',
  isChecked: true,
  priority: Priority.high,
  createdAt: DateTime.fromMillisecondsSinceEpoch(1000),
  changedAt: DateTime.fromMillisecondsSinceEpoch(1001),
  deviceId: 'phone',
  id: '110ec58a-a0f2-4ac4-8393-c866d813b8da',
);

final TaskModel taskB = TaskModel(
  description: 'task b',
  isChecked: true,
  priority: Priority.high,
  createdAt: DateTime.fromMillisecondsSinceEpoch(1500),
  changedAt: DateTime.fromMillisecondsSinceEpoch(1501),
  deviceId: 'phone',
  id: '110ec58a-a0f2-4ac4-8393-c866d813b8db',
);

final TaskModel taskC = TaskModel(
  description: 'task c',
  isChecked: true,
  priority: Priority.high,
  createdAt: DateTime.fromMillisecondsSinceEpoch(1500),
  changedAt: DateTime.fromMillisecondsSinceEpoch(1501),
  deviceId: 'phone',
  id: '110ec58a-a0f2-4ac4-8393-c866d813b8dc',
);
