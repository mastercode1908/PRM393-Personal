import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notifications
  final NotificationService notificationService = NotificationService();
  await notificationService.init();

  runApp(const Lab10App());
}

class Lab10App extends StatelessWidget {
  const Lab10App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 10 - Auth & Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Start with Splash Screen for Auto-Login routing (Lab 10.3)
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
