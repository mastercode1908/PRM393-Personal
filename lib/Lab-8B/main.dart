import 'package:flutter/material.dart';
import 'screens/weather_home_screen.dart';

void main() {
  runApp(const Lab8BApp());
}

class Lab8BApp extends StatelessWidget {
  const Lab8BApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Companion (Lab 8B)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WeatherHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
