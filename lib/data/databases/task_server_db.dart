import 'package:http/http.dart';

import '../models/task.dart';

abstract interface class TaskServerDB {
  Future<List<Task>> getTasksList();

  Future<void> addTask(Task newTask);

  Future<void> removeTask(String id);

  Future<void> updateTask(String id, Task newTask);

  Future<void> patchTasks(List<Task> tasks);

  Future<void> getTask(String id);
}

class TaskServerDBImpl implements TaskServerDB {
  final _url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
  final cl = _MyClient();

  @override
  Future<void> addTask(Task newTask) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasksList() {
    // TODO: implement getTasksList
    throw UnimplementedError();
  }

  @override
  Future<void> patchTasks(List<Task> tasks) {
    // TODO: implement patchTasks
    throw UnimplementedError();
  }

  @override
  Future<void> removeTask(String id) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String id, Task newTask) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}

class _MyClient extends BaseClient {
  final client = Client();
  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = 'Bearer parachaplain';
    return client.send(request);
  }
}
