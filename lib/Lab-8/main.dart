import 'package:flutter/material.dart';
import 'screens/post_list_screen.dart';

void main() {
  runApp(const Lab8App());
}

class Lab8App extends StatelessWidget {
  const Lab8App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8 - Networking API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
