import 'package:todo/models/models.dart';
import 'package:todo/services/services.dart';

class Repository {
  final TodoApiProvider _todoApiProvider = TodoApiProvider();

  Future<List<TodoModel>> getTodo() => _todoApiProvider.getTodo();

  Future<int> toggleIsComplete(id, todo) =>
      _todoApiProvider.toggleIsComplete(id, todo);

  Future<int> addTodo(todo) => _todoApiProvider.addTodo(todo);

  Future<int> editTodo(id, todo) => _todoApiProvider.editTodo(id, todo);

  Future<int> deleteTodo(id) => _todoApiProvider.deleteTodo(id);
}
