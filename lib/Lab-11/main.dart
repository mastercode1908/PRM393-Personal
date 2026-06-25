import 'package:flutter/material.dart';
import 'repositories/task_repository.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const TasklyApp());
}

class TasklyApp extends StatelessWidget {
  const TasklyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly - Lab 11',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(repository: TaskRepository()),
    );
  }
}
