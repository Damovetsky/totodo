import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../core/error/exeption.dart';
import '../../logger.dart';
import '../models/task.dart';

abstract interface class TaskServer {
  Future<Map<String, dynamic>> getTasksList();

  Future<void> addTask(Task newTask, int revision);

  Future<void> removeTask(String id, int revision);

  Future<void> updateTask(String id, Task newTask, int revision);

  Future<void> patchTasks(List<Task> tasks, int revision);

  Future<void> getTask(String id);
}

class TaskServerImpl implements TaskServer {
  final cl = _MyClient();

  @override
  Future<void> addTask(Task newTask, int revision) async {
    final url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final encodedData = json.encode({'element': newTask.toJson()});
    try {
      final response = await cl.post(
        url,
        headers: {
          'X-Last-Known-Revision': '$revision',
        },
        body: encodedData,
      );
      switch (response.statusCode) {
        case 200:
          {
            return;
          }
        case 400:
          {
            if (response.body == 'unsynchronized data') {
              logger.i('Data bases are unsynchronized');
              throw UnsynchronizedDataException();
            }
            logger.e('Bad http request to the server');
            throw BadHttpRequestException();
          }
        case 500:
          {
            logger.e('Server is not feeling well today');
            throw ServerErrorException();
          }
        default:
          {
            throw UnknownServerException();
          }
      }
    } on SocketException {
      logger.i('No Internet connection');
      rethrow;
    } on HttpException {
      logger.e("Couldn't find the post");
      rethrow;
    } on FormatException {
      logger.e('Bad response format');
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  //Maybe I'll need it in the future
  @override
  Future<void> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<void> patchTasks(List<Task> tasks, int revision) async {
    final url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final encodedData = jsonEncode(tasks.map((task) => task.toJson()).toList());
    try {
      final response = await cl.patch(
        url,
        headers: {
          'X-Last-Known-Revision': '$revision',
        },
        body: encodedData,
      );
      switch (response.statusCode) {
        case 200:
          {
            return;
          }
        case 400:
          {
            logger.e('Bad http request to the server');
            throw BadHttpRequestException();
          }
        case 500:
          {
            logger.e('Server is not feeling well today');
            throw ServerErrorException();
          }
        default:
          {
            throw UnknownServerException();
          }
      }
    } on SocketException {
      logger.i('No Internet connection');
      rethrow;
    } on HttpException {
      logger.e("Couldn't find the post");
      rethrow;
    } on FormatException {
      logger.e('Bad response format');
      rethrow;
    } catch (e) {
      logger.e('An error occured when conecting with server: $e');
      throw UnknownException();
    }
  }

  @override
  Future<void> removeTask(String id, int revision) async {
    final url = Uri.parse('https://beta.mrdekk.ru/todobackend/list/$id');
    try {
      final response = await cl.delete(
        url,
        headers: {
          'X-Last-Known-Revision': '$revision',
        },
      );
      switch (response.statusCode) {
        case 200:
          {
            return;
          }
        case 400:
          {
            if (response.body == 'unsynchronized data') {
              logger.i('Data bases are unsynchronized');
              throw UnsynchronizedDataException();
            }
            logger.e('Bad http request to the server');
            throw BadHttpRequestException();
          }
        case 500:
          {
            logger.e('Server is not feeling well today');
            throw ServerErrorException();
          }
        default:
          {
            throw UnknownServerException();
          }
      }
    } on SocketException {
      logger.i('No Internet connection');
      rethrow;
    } on HttpException {
      logger.e("Couldn't find the post");
      rethrow;
    } on FormatException {
      logger.e('Bad response format');
      rethrow;
    } catch (e) {
      logger.e('An error occured when conecting with server: $e');
      throw UnknownException();
    }
  }

  @override
  Future<void> updateTask(String id, Task newTask, int revision) async {
    final url = Uri.parse('https://beta.mrdekk.ru/todobackend/list/$id');
    final encodedData = json.encode({'element': newTask.toJson()});
    try {
      final response = await cl.put(
        url,
        headers: {
          'X-Last-Known-Revision': '$revision',
        },
        body: encodedData,
      );
      switch (response.statusCode) {
        case 200:
          {
            return;
          }
        case 400:
          {
            if (response.body == 'unsynchronized data') {
              logger.i('Data bases are unsynchronized');
              throw UnsynchronizedDataException();
            }
            logger.e('Bad http request to the server');
            throw BadHttpRequestException();
          }
        case 500:
          {
            logger.e('Server is not feeling well today');
            throw ServerErrorException();
          }
        default:
          {
            throw UnknownServerException();
          }
      }
    } on SocketException {
      logger.i('No Internet connection');
      rethrow;
    } on HttpException {
      logger.e("Couldn't find the post");
      rethrow;
    } on FormatException {
      logger.e('Bad response format');
      rethrow;
    } catch (e) {
      logger.e('An error occured when conecting with server: $e');
      throw UnknownException();
    }
  }

  @override
  Future<Map<String, dynamic>> getTasksList() async {
    final url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    try {
      final response = await cl.get(url);
      switch (response.statusCode) {
        case 200:
          {
            final extractedData =
                json.decode(response.body) as Map<String, dynamic>;
            return extractedData;
          }
        case 400:
          {
            logger.e('Bad http request to the server');
            throw BadHttpRequestException();
          }
        case 500:
          {
            logger.e('Server is not feeling well today');
            throw ServerErrorException();
          }
        default:
          {
            throw UnknownServerException();
          }
      }
    } on SocketException {
      logger.i('No Internet connection');
      rethrow;
    } on HttpException {
      logger.e("Couldn't find the post");
      rethrow;
    } on FormatException {
      logger.e('Bad response format');
      rethrow;
    } catch (e) {
      logger.e('An error occured when conecting with server: $e');
      throw UnknownException();
    }
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
