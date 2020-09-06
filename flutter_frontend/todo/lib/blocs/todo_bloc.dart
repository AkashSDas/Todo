import 'dart:async';

import 'package:todo/models/models.dart';
import 'package:todo/services/repository.dart';

class TodoBloc {
  final _repository = Repository();
  final _controller = StreamController.broadcast();

  get todoStream => _controller.stream;

  getTodoData() async {
    List<TodoModel> todos = await _repository.getTodo();
    _controller.sink.add(todos);
  }

  toggleIsComplete(int id, TodoModel todo) async {
    await _repository.toggleIsComplete(id, todo);
    this.getTodoData();
  }

  dispose() {
    _controller?.close();
  }
}
