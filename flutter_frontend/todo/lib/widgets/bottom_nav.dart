import 'package:flutter/material.dart';
import 'package:todo/blocs/todo_bloc.dart';

Widget bottomNav(BuildContext context, TodoBloc todoBloc) {
  return BottomNavigationBar(
    items: [
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            todoBloc.getTodoData();
          },
        ),
        title: Text('Refresh'),
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/add_todo');
          },
        ),
        title: Text('Add'),
      ),
    ],
  );
}
