import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/models/task.dart';

class TasksServer {
  Future<List<Task>> getTasks() async {
    final url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer parachaplain'});
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    return [];
  }

  Future<void> addTask() async {
    final url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer parachaplain',
        'X-Last-Known-Revision': '1',
      },
      body: json.encode(
        {
          'element': {
            'id': 'abcd',
            'text': 'blablabla',
            'importance': 'important',
            'deadline': null,
            'color': null,
            'done': false,
            'changed_at': 1687136129,
            'created_at': 1687136128,
            'last_updated_by': '123'
          },
        },
      ),
    );
    final status = response.statusCode;
    print(status);
  }
}
