import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../core/error/exeption.dart';
import '../../../logger.dart';
import 'constants/server_constants.dart';
import 'dto/task_dto.dart';
import 'dto/task_response_dto.dart';
import 'dto/tasks_list_dto.dart';

abstract interface class TasksServer {
  Future<TasksListDto> getTasksList();

  Future<TaskResponseDto> addTask(TaskDto newTask);

  Future<TaskResponseDto> removeTask(String id);

  Future<TaskResponseDto> updateTask(String id, TaskDto newTask);

  Future<TasksListDto> patchTasks(List<TaskDto> tasks);
}

@Injectable(as: TasksServer)
class TasksServerImpl implements TasksServer {
  final cl = _MyClient();
  final SharedPreferences _prefs;

  TasksServerImpl(this._prefs);

  @override
  Future<TaskResponseDto> addTask(TaskDto newTask) async {
    final url =
        Uri.parse('${ServerConstants.baseUrl}${ServerConstants.listEndpoint}');
    final encodedData = json.encode({'element': newTask.toJson()});
    try {
      final response = await cl.post(
        url,
        headers: {
          'X-Last-Known-Revision':
              '${_prefs.getInt(sharedPreferencesRevisionKey)}',
        },
        body: encodedData,
      );
      switch (response.statusCode) {
        case 200:
          {
            final taskResponseDto = TaskResponseDto.fromJson(
              json.decode(response.body) as Map<String, dynamic>,
            );
            _prefs.setInt(
              sharedPreferencesRevisionKey,
              taskResponseDto.revision,
            );
            _prefs.setInt(
              lastServerRevisionTimeKey,
              DateTime.now().millisecondsSinceEpoch,
            );
            return taskResponseDto;
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
    } on UnsynchronizedDataException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TasksListDto> patchTasks(List<TaskDto> tasks) async {
    final url =
        Uri.parse('${ServerConstants.baseUrl}${ServerConstants.listEndpoint}');
    final encodedData = jsonEncode({'list': tasks});
    //final encodedData = jsonEncode(tasks.map((task) => task.toJson()).toList());
    try {
      final response = await cl.patch(
        url,
        headers: {
          'X-Last-Known-Revision':
              '${_prefs.getInt(sharedPreferencesRevisionKey)}',
        },
        body: encodedData,
      );
      switch (response.statusCode) {
        case 200:
          {
            final extractedData = TasksListDto.fromJson(
              json.decode(response.body) as Map<String, dynamic>,
            );
            _prefs.setInt(
              sharedPreferencesRevisionKey,
              extractedData.revision,
            );
            _prefs.setInt(
              lastServerRevisionTimeKey,
              DateTime.now().millisecondsSinceEpoch,
            );
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
      rethrow;
    }
  }

  @override
  Future<TaskResponseDto> removeTask(String id) async {
    final url = Uri.parse(
      '${ServerConstants.baseUrl}${ServerConstants.listEndpoint}$id',
    );
    try {
      final response = await cl.delete(
        url,
        headers: {
          'X-Last-Known-Revision':
              '${_prefs.getInt(sharedPreferencesRevisionKey)}',
        },
      );
      switch (response.statusCode) {
        case 200:
          {
            final taskResponseDto = TaskResponseDto.fromJson(
              json.decode(response.body) as Map<String, dynamic>,
            );
            _prefs.setInt(
              sharedPreferencesRevisionKey,
              taskResponseDto.revision,
            );
            _prefs.setInt(
              lastServerRevisionTimeKey,
              DateTime.now().millisecondsSinceEpoch,
            );
            return taskResponseDto;
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
        case 404:
          {
            logger.e('Task was not found while deleting');
            throw ElementNotFoundException();
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
    } on UnsynchronizedDataException {
      rethrow;
    } catch (e) {
      logger.e('An error occured when conecting with server: $e');
      throw UnknownException();
    }
  }

  @override
  Future<TaskResponseDto> updateTask(String id, TaskDto newTask) async {
    final url = Uri.parse(
      '${ServerConstants.baseUrl}${ServerConstants.listEndpoint}$id',
    );
    final encodedData = json.encode({'element': newTask.toJson()});
    try {
      final response = await cl.put(
        url,
        headers: {
          'X-Last-Known-Revision':
              '${_prefs.getInt(sharedPreferencesRevisionKey)}',
        },
        body: encodedData,
      );
      switch (response.statusCode) {
        case 200:
          {
            final taskResponseDto = TaskResponseDto.fromJson(
              json.decode(response.body) as Map<String, dynamic>,
            );
            _prefs.setInt(
              sharedPreferencesRevisionKey,
              taskResponseDto.revision,
            );
            _prefs.setInt(
              lastServerRevisionTimeKey,
              DateTime.now().millisecondsSinceEpoch,
            );
            return taskResponseDto;
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
    } on UnsynchronizedDataException {
      rethrow;
    } catch (e) {
      logger.e('An error occured when conecting with server: $e');
      throw UnknownException();
    }
  }

  @override
  Future<TasksListDto> getTasksList() async {
    final url =
        Uri.parse('${ServerConstants.baseUrl}${ServerConstants.listEndpoint}');
    try {
      final response = await cl.get(url);
      switch (response.statusCode) {
        case 200:
          {
            final extractedData = TasksListDto.fromJson(
              json.decode(response.body) as Map<String, dynamic>,
            );
            _prefs.setInt(
              sharedPreferencesRevisionKey,
              extractedData.revision,
            );
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
    request.headers['Authorization'] = 'Bearer ${ServerConstants.accessToken}';
    return client.send(request);
  }
}
