import 'package:flutter/material.dart';
import 'screens/crud_home_screen.dart';

void main() {
  runApp(const Lab9App());
}

class Lab9App extends StatelessWidget {
  const Lab9App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local JSON Storage',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const CrudHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
