import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndRedirect();
  }

  Future<void> _checkTokenAndRedirect() async {
    // Logic Khởi động: Kiểm tra Token cục bộ
    // Simulate checking token with a delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      // Chuyển hướng màn hình (Transition callvut Khởi động)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Developer handoff:
    // Material Color: Primary Purple, Surface White, On-Surface Black
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.auto_awesome,
                  size: 50,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Loading Spinner
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
            ),
          ],
        ),
      ),
    );
  }
}
