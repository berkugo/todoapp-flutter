import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:todoapp/models/TodoModel.dart';

class HttpClient {
  // static const String _urlPrefix = "https://api.furkankadirsazan.com/home/";
  static const String _urlPrefix = "http://localhost:3000";

  static Future<bool> makePostRequest(TodoModel model) async {
    final int taskId = model.taskId;
    final String title = model.title;
    final String deadline = model.deadline;
    final url = Uri.parse('$_urlPrefix/inserttodo');
    final headers = {"Content-type": "application/json"};
    final json =
        '{"taskId": "$taskId", "title": "$title", "deadline": "$deadline"}';
    final response = await post(url, headers: headers, body: json);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  static Future<List<TodoModel>> makeGetRequest() async {
    final url = Uri.parse('$_urlPrefix/getall');
    Response response = await get(url);
    List<dynamic> responseList = (json.decode(response.body));
    TodoModel.instances.clear();
    for (Map<String, dynamic> map in responseList) {
      TodoModel.createInstance(map['title'], map['deadline']);
    }
    return TodoModel.instances;
  }
}
