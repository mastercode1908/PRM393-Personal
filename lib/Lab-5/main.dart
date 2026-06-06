import 'package:flutter/material.dart';
import 'screens/movie_home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 - Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Make the app look modern
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MovieHomeScreen(),
      // Optional: If you want to show how Named Routes work, you could define them here.
      // But we are using Navigator.push + MaterialPageRoute as required.
    );
  }
}
