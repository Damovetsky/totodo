import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totodo/constants.dart';
import 'package:totodo/data/converters/db_dto_task_converter.dart';
import 'package:totodo/data/converters/domain_db_task_converter.dart';
import 'package:totodo/data/converters/domain_dto_task_converter.dart';
import 'package:totodo/data/services/tasks_db/task_db_model/task_db.dart';
import 'package:totodo/data/services/tasks_server/dto/task_dto.dart';
import 'package:totodo/domain/models/task_model.dart';
import 'package:totodo/domain/repositories/tasks_repository.dart';

import 'data/database_tasks.dart';
import 'data/server_tasks.dart';
import 'data/mock_tasks.dart';
import 'test_constants.dart';
import 'test_doubles/database_api_mock.mocks.dart';
import 'test_doubles/server_api_mock.mocks.dart';

void main() {
  group(
    'repository tests',
    () {
      test(
        'Get database tasks test',
        () async {
          final server = MockTasksServer();
          final db = MockTasksDB();
          SharedPreferences.setMockInitialValues({});
          final prefs = await SharedPreferences.getInstance();

          final repository =
              TasksRepositoryImpl(prefs: prefs, server: server, db: db);

          when(db.getTasksList()).thenAnswer((_) async => mockDBTasks);

          final tasksList = await repository.getDBTasks();

          expect(tasksList, mockTasks);
        },
      );

      test(
        'Get server tasks test (when server has newer data)',
        () async {
          final server = MockTasksServer();
          final db = MockTasksDB();
          SharedPreferences.setMockInitialValues(
            {sharedPreferencesRevisionKey: 1, hasLocalChangesKey: false},
          );
          final prefs = await SharedPreferences.getInstance();

          final repository =
              TasksRepositoryImpl(prefs: prefs, server: server, db: db);

          when(server.getTasksList()).thenAnswer((_) async {
            prefs.setInt(
              sharedPreferencesRevisionKey,
              mockDtoTasksList.revision,
            );
            return mockDtoTasksList;
          });

          when(db.patchTasks(mockDBTasks)).thenAnswer((_) async {});

          final tasksList = await repository.getServerTasks();

          expect(tasksList, mockTasks);
        },
      );

      test(
        'Get server tasks test (when data is synchronized)',
        () async {
          final server = MockTasksServer();
          final db = MockTasksDB();
          SharedPreferences.setMockInitialValues(
            {
              sharedPreferencesRevisionKey: dataRevision1,
              hasLocalChangesKey: false,
            },
          );
          final prefs = await SharedPreferences.getInstance();

          final repository =
              TasksRepositoryImpl(prefs: prefs, server: server, db: db);

          when(server.getTasksList()).thenAnswer((_) async {
            prefs.setInt(
              sharedPreferencesRevisionKey,
              mockDtoTasksListWithFirstRevision.revision,
            );
            return mockDtoTasksListWithFirstRevision;
          });

          final tasksList = await repository.getServerTasks();

          expect(tasksList, null);
        },
      );

      test(
        'Get server tasks test (when database has newer data)',
        () async {
          final server = MockTasksServer();
          final db = MockTasksDB();
          SharedPreferences.setMockInitialValues(
            {
              sharedPreferencesRevisionKey: dataRevision5,
              hasLocalChangesKey: true,
            },
          );
          final prefs = await SharedPreferences.getInstance();

          final repository =
              TasksRepositoryImpl(prefs: prefs, server: server, db: db);

          when(server.getTasksList()).thenAnswer((_) async {
            prefs.setInt(
              sharedPreferencesRevisionKey,
              mockDtoTasksList.revision,
            );
            return mockDtoTasksList;
          });

          when(db.getTasksList()).thenAnswer(
            (_) async => mockDBTasks,
          );

          when(server.patchTasks([dtoTaskA, dtoTaskB]))
              .thenAnswer((_) async => mockDtoTasksList);

          final tasksList = await repository.getServerTasks();

          expect(tasksList, null);
        },
      );

      test(
        'Get server tasks test (when database and server both have newer data and it is unsyncronized)',
        () async {
          final server = MockTasksServer();
          final db = MockTasksDB();
          SharedPreferences.setMockInitialValues(
            {
              sharedPreferencesRevisionKey: dataRevision1,
              hasLocalChangesKey: true,
              lastServerRevisionTimeKey: 1200,
            },
          );
          final prefs = await SharedPreferences.getInstance();

          final repository =
              TasksRepositoryImpl(prefs: prefs, server: server, db: db);

          when(server.getTasksList()).thenAnswer((_) async {
            prefs.setInt(
              sharedPreferencesRevisionKey,
              mockDtoTasksList.revision,
            );
            return mockDtoTasksList;
          });

          when(db.getTasksList()).thenAnswer(
            (_) async => mockDBTasksWithTasksAC,
          );

          when(server.patchTasks([dtoTaskA, dtoTaskC, dtoTaskB]))
              .thenAnswer((_) async => mockDtoTasksList);

          when(db.patchTasks([dbTaskA, dbTaskB, dbTaskC]))
              .thenAnswer((_) async {});

          final tasksList = await repository.getServerTasks();

          expect(tasksList, mockMergedTasks);
        },
      );
    },
  );

  group(
    'Domain task model tests',
    () {
      final TaskModel task = taskA;

      test(
        'Convert domain task to database task',
        () {
          final TaskDB dbTask = task.toDB();
          expect(dbTask, dbTaskA);
        },
      );

      test(
        'Convert domain task to dto task',
        () {
          final TaskDto dtoTask = task.toDto();
          expect(dtoTask, dtoTaskA);
        },
      );
    },
  );

  group(
    'Dto task model tests',
    () {
      final TaskDto task = dtoTaskA;

      test(
        'Convert dto task to database task',
        () {
          final TaskDB dbTask = task.toDB();
          expect(dbTask, dbTaskA);
        },
      );

      test(
        'Convert dto task to domain task',
        () {
          final TaskModel domainTask = task.toDomain();
          expect(domainTask, taskA);
        },
      );
    },
  );

  group(
    'Database task model tests',
    () {
      final TaskDB task = dbTaskA;

      test(
        'Convert database task to dto task',
        () {
          final TaskDto dtoTask = task.toDto();
          expect(dtoTask, dtoTaskA);
        },
      );

      test(
        'Convert database task to domain task',
        () {
          final TaskModel domainTask = task.toDomain();
          expect(domainTask, taskA);
        },
      );
    },
  );
}
