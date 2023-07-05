// Mocks generated by Mockito 5.4.2 from annotations
// in totodo/test/test_doubles/database_api_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:totodo/data/services/tasks_db/task_db_model/task_db.dart'
    as _i4;
import 'package:totodo/data/services/tasks_db/tasks_db.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TasksDB].
///
/// See the documentation for Mockito's code generation for more information.
class MockTasksDB extends _i1.Mock implements _i2.TasksDB {
  MockTasksDB() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.TaskDB>> getTasksList() => (super.noSuchMethod(
        Invocation.method(
          #getTasksList,
          [],
        ),
        returnValue: _i3.Future<List<_i4.TaskDB>>.value(<_i4.TaskDB>[]),
      ) as _i3.Future<List<_i4.TaskDB>>);
  @override
  _i3.Future<void> addTask(_i4.TaskDB? newTask) => (super.noSuchMethod(
        Invocation.method(
          #addTask,
          [newTask],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> removeTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #removeTask,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> updateTask(
    String? id,
    _i4.TaskDB? newTask,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [
            id,
            newTask,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> patchTasks(List<_i4.TaskDB>? tasks) => (super.noSuchMethod(
        Invocation.method(
          #patchTasks,
          [tasks],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
