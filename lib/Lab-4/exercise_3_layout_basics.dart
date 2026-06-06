import 'package:flutter/material.dart';

class LayoutBasicsDemo extends StatelessWidget {
  LayoutBasicsDemo({super.key});

  final List<String> _movies = [
    'Inception',
    'Interstellar',
    'The Dark Knight',
    'Dune',
    'Avatar',
    'The Matrix',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3: Layout Basics'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Header with Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Popular Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.movie, color: Colors.red),
              ],
            ),
          ),
          
          // Section 2: Spacing
          const SizedBox(height: 8), // Consistent spacing
          
          // Section 3: ListView showing movie titles
          // We use Expanded so the ListView takes remaining vertical space
          Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.play_arrow),
                      ),
                      title: Text(_movies[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
