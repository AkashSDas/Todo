import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo/widgets/add_todo.dart';

import 'widgets/home.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Home(),
        '/add_todo': (BuildContext context) => AddTodo(),
      },
    );
  }
}
