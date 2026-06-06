import 'package:flutter/material.dart';

class AppStructureDemo extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const AppStructureDemo({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    // We use a Scaffold to structure the screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4: App Structure'),
        actions: [
          // Dark Mode toggle button in the AppBar
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
            tooltip: 'Toggle Dark Mode',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'App Structure with Scaffold & Theme',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Current Theme: ${isDarkMode ? "Dark" : "Light"}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      // FloatingActionButton for common action
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB clicked!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
