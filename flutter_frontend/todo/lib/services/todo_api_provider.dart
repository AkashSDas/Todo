import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo/models/models.dart';

class TodoApiProvider {
  final _baseUrl = '${DotEnv().env['BACKEND']}';

  // Retrive all todos
  Future<List<TodoModel>> getTodo() async {
    Dio dio = Dio();
    Response response = await dio.get('${this._baseUrl}todo/');
    List<TodoModel> todos = [];

    if (response.statusCode == 200) {
      for (int i = 0; i < response.data.length; i++) {
        todos.add(TodoModel.fromJson(response.data[i]));
      }
    } else {
      print('💃 getTodo, Status code: ${response.statusCode}');
    }

    return todos;
  }

  // Toggle isComplete Status
  Future<int> toggleIsComplete(int id, TodoModel todo) async {
    Dio dio = Dio();
    todo.isCompleted = !todo.isCompleted;
    Map<String, dynamic> todoData = todo.toMap();
    Response response =
        await dio.put('${this._baseUrl}todo/$id/', data: todoData);

    if (response.statusCode == 200) {
      return 1; // Success
    } else {
      print('💃 toggleIsComplete, Status code: ${response.statusCode}');
      return 0; // Error
    }
  }

  // Add todo
  Future<int> addTodo(TodoModel todo) async {
    Dio dio = Dio();
    Map<String, dynamic> todoData = todo.toMap();
    Response response = await dio.post('${this._baseUrl}todo/', data: todoData);

    if (response.statusCode == 200) {
      return 1; // Success
    } else {
      print('💃 addTodo, Status code: ${response.statusCode}');
      return 0; // Error
    }
  }

  // Edit todo
  Future<int> editTodo(int id, TodoModel todo) async {
    Dio dio = Dio();
    Map<String, dynamic> todoData = todo.toMap();
    Response response =
        await dio.put('${this._baseUrl}todo/$id/', data: todoData);

    if (response.statusCode == 200) {
      return 1; // Success
    } else {
      print('💃 editTodo, Status code: ${response.statusCode}');
      return 0; // Error
    }
  }

  // Delete todo
  Future<int> deleteTodo(int id) async {
    Dio dio = Dio();
    Response response = await dio.delete('${this._baseUrl}todo/$id/');

    if (response.statusCode == 200) {
      return 1; // Success
    } else {
      print('💃 deleteTodo, Status code: ${response.statusCode}');
      return 0; // Error
    }
  }
}
