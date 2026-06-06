import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(const SignupApp());
}

class SignupApp extends StatelessWidget {
  const SignupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Form Validation',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        // Make text fields look a bit nicer globally
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const SignupScreen(),
    );
  }
}
