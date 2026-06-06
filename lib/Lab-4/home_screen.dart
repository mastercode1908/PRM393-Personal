import 'package:flutter/material.dart';

import 'exercise_1_core_widgets.dart';
import 'exercise_2_input_controls.dart';
import 'exercise_3_layout_basics.dart';
import 'exercise_4_app_structure.dart';
import 'exercise_5_debug_fixes.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4: UI Fundamentals'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
            tooltip: 'Toggle Dark Mode',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoreWidgetsDemo()),
              );
            },
            child: const Text('Exercise 1: Core Widgets'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InputControlsDemo()),
              );
            },
            child: const Text('Exercise 2: Input Controls'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LayoutBasicsDemo()),
              );
            },
            child: const Text('Exercise 3: Layout Basics'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppStructureDemo(
                    onToggleTheme: onToggleTheme,
                    isDarkMode: isDarkMode,
                  ),
                ),
              );
            },
            child: const Text('Exercise 4: App Structure'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DebugFixesDemo()),
              );
            },
            child: const Text('Exercise 5: Debug & Fixes'),
          ),
        ],
      ),
    );
  }
}
