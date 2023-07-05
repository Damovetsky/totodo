import 'package:totodo/data/services/tasks_server/dto/task_dto.dart';
import 'package:totodo/data/services/tasks_server/dto/tasks_list_dto.dart';

import '../test_constants.dart';

final TasksListDto mockDtoTasksList = TasksListDto(
  status: 'ок',
  list: [dtoTaskA, dtoTaskB],
  revision: dataRevision5,
);

final TasksListDto mockDtoTasksListWithFirstRevision = TasksListDto(
  status: 'ок',
  list: [dtoTaskA, dtoTaskB],
  revision: dataRevision1,
);

const TaskDto dtoTaskA = TaskDto(
  id: '110ec58a-a0f2-4ac4-8393-c866d813b8da',
  text: 'task a',
  done: true,
  importance: Importance.important,
  createdAt: 1000,
  changedAt: 1001,
  lastUpdatedBy: 'phone',
);
const TaskDto dtoTaskB = TaskDto(
  id: '110ec58a-a0f2-4ac4-8393-c866d813b8db',
  text: 'task b',
  done: true,
  importance: Importance.important,
  createdAt: 1500,
  changedAt: 1501,
  lastUpdatedBy: 'phone',
);

const TaskDto dtoTaskC = TaskDto(
  id: '110ec58a-a0f2-4ac4-8393-c866d813b8dc',
  text: 'task c',
  done: true,
  importance: Importance.important,
  createdAt: 1500,
  changedAt: 1501,
  lastUpdatedBy: 'phone',
);
