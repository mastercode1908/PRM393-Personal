import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const TasklyApp(),
    ),
  );
}

class TasklyApp extends StatefulWidget {
  const TasklyApp({Key? key}) : super(key: key);

  @override
  State<TasklyApp> createState() => _TasklyAppState();
}

class _TasklyAppState extends State<TasklyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Exercise 12.2: Pre-cache frequently used images
    precacheImage(const AssetImage('assets/images/logo.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly Optimized - Lab 12',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
