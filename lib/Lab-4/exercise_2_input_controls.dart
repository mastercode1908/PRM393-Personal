import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // State variables for inputs
  double _sliderValue = 50.0;
  bool _switchValue = false;
  int _radioValue = 1;
  DateTime? _selectedDate;

  // Function to show DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
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
        title: const Text('Exercise 2: Input Controls'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slider widget
            const Text('Slider:', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: _sliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            Text('Slider Value: ${_sliderValue.round()}'),
            const Divider(),

            // Switch widget
            const Text('Switch:', style: TextStyle(fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text('Enable feature'),
              value: _switchValue,
              onChanged: (bool value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            Text('Switch is: ${_switchValue ? "ON" : "OFF"}'),
            const Divider(),

            // RadioListTile widgets
            const Text('Radio Group:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<int>(
              title: const Text('Option 1'),
              value: 1,
              groupValue: _radioValue,
              onChanged: (int? value) {
                setState(() {
                  _radioValue = value!;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('Option 2'),
              value: 2,
              groupValue: _radioValue,
              onChanged: (int? value) {
                setState(() {
                  _radioValue = value!;
                });
              },
            ),
            Text('Selected Option: $_radioValue'),
            const Divider(),

            // DatePicker button
            const Text('Date Picker:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 10),
            Text(
              'Selected Date: ${_selectedDate == null ? "None" : "${_selectedDate!.toLocal()}".split(' ')[0]}',
            ),
          ],
        ),
      ),
    );
  }
}
