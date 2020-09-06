import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/edit_todo.dart';

Widget buildTodoList(
  BuildContext context,
  snapshot,
  todoBloc,
  formatDateTime,
  priorityText,
  repository,
) {
  List<TodoModel> data = snapshot.data;

  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              await repository.deleteTodo(data[index].id);
            },
          ),
        ],
        child: ListTile(
          title: Text(data[index].title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              data[index].deadline != null
                  ? Text(formatDateTime(data[index].deadline))
                  : Text(''),
              priorityText(data[index].priority),
            ],
          ),
          leading: MaterialButton(
            onPressed: () async {
              print(data[index].deadline.toString());
              await todoBloc.toggleIsComplete(data[index].id, data[index]);
              print('is complete btn pressed');
            },
            child: data[index].isCompleted ? Text('✅') : Text('❌'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodo(todo: data[index]),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
