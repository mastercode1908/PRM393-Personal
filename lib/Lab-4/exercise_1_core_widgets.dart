import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Core Widgets'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // A headline Text
              const Text(
                'Welcome to Flutter UI',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // An Icon using Material Icons
              const Icon(
                Icons.flutter_dash,
                size: 64,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              
              // An Image.network()
              Image.network(
                'https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png',
                height: 150,
                errorBuilder: (context, error, stackTrace) => const Text('Image failed to load'),
              ),
              const SizedBox(height: 20),
              
              // A Card containing a ListTile
              const Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Core Widget Card'),
                  subtitle: Text('This is a ListTile inside a Card'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
