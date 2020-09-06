import 'package:flutter/material.dart';
import 'package:todo/blocs/todo_bloc.dart';
import 'package:todo/models/Todo.dart';
import 'package:todo/services/repository.dart';
import 'package:todo/widgets/bottom_nav.dart';
import 'package:todo/widgets/todo_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TodoModel> todos;
  bool reload = false;
  TodoBloc todoBloc = TodoBloc();
  Repository repository = Repository();

  String formatDateTime(DateTime dateTime) {
    if (dateTime == null) {
      return null;
    }
    String dateTimeTmp = dateTime.toString();
    String date = dateTimeTmp.split(' ')[0];
    String time = dateTimeTmp.split(' ')[1];
    String hour = time.split(':')[0];
    String min = time.split(':')[1];

    if (int.parse(hour) < 12) {
      return '$date $hour:$min am';
    }
    return '$date $hour:$min pm';
  }

  // 0: Low, 1: Medium, 2: High
  Text priorityText(int priorityIndex) {
    if (priorityIndex == 0) {
      return Text(
        '!',
        style: TextStyle(color: Colors.purple, fontSize: 30),
      );
    } else if (priorityIndex == 1) {
      return Text(
        '!!',
        style: TextStyle(color: Colors.yellow, fontSize: 30),
      );
    } else if (priorityIndex == 2) {
      return Text(
        '!!!',
        style: TextStyle(color: Colors.red, fontSize: 30),
      );
    }
    return Text(
      'no priority',
      style: TextStyle(color: Colors.black, fontSize: 30),
    );
  }

  @override
  void initState() {
    super.initState();
    this.todoBloc.getTodoData();
  }

  @override
  dispose() {
    super.dispose();
    this.todoBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder(
          stream: this.todoBloc.todoStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildTodoList(
                context,
                snapshot,
                todoBloc,
                formatDateTime,
                priorityText,
                repository,
              );
            } else if (snapshot.hasError) {
              print("snapshot hasError");
              return Text(snapshot.error.toString());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNav(context, todoBloc),
    );
  }
}
