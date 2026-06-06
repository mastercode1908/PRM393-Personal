import 'package:flutter/material.dart';

class DebugFixesDemo extends StatefulWidget {
  const DebugFixesDemo({super.key});

  @override
  State<DebugFixesDemo> createState() => _DebugFixesDemoState();
}

class _DebugFixesDemoState extends State<DebugFixesDemo> {
  int _counter = 0;
  DateTime? _selectedDate;

  // Fix 3: Proper state update using setState()
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Fix 4: Correct DatePicker build context error by calling it from a valid context
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, // Ensure this context has a Navigator
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5: Debug & Fixes'),
      ),
      // Fix 2: Fix overflow in small screens using SingleChildScrollView
      // We wrap the main Column in a Column, but wait, if we have an Expanded ListView, 
      // SingleChildScrollView and Expanded don't mix well. 
      // To demonstrate SingleChildScrollView fixing overflow, we'll put some wide/tall widgets here.
      // But we also need to demonstrate ListView inside Column using Expanded.
      // Let's split them into tabs or separate columns if needed, or just combine them properly.
      body: Column(
        children: [
          // Demonstration of fixing overflow using SingleChildScrollView for a specific section
          SizedBox(
            height: 150,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('This section is wrapped in SingleChildScrollView to prevent overflow when content is too tall.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment State'),
                  ),
                  Text('State Counter: $_counter (Fixed with setState)'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date (Fixed context)'),
                  ),
                  Text(
                    'Selected Date: ${_selectedDate == null ? "None" : "${_selectedDate!.toLocal()}".split(' ')[0]}',
                  ),
                  const SizedBox(height: 50), // Force some scrollable space
                  const Text('Scrollable Content...'),
                ],
              ),
            ),
          ),
          
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Expanded ListView (Fixed inside Column):', style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          // Fix 1: Fix ListView inside Column using Expanded
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
