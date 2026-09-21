import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Exercise 1 – Core Widgets Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Flutter UI',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          const Center(child: Icon(Icons.movie, size: 80, color: Colors.blue)),
          const SizedBox(height: 32),
          Image.network(
            'https://images.unsplash.com/photo-1542281286-9e0a16bb7366?w=900',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            semanticLabel: 'Landscape photograph',
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              child: const Text('Image loading error. Check your connection.'),
            ),
          ),
          const SizedBox(height: 24),
          const Card(
            child: ListTile(
              leading: Icon(Icons.star),
              title: Text('Movie Item'),
              subtitle: Text('This is a sample ListTile inside a Card.'),
            ),
          ),
        ],
      ),
    ),
  );
}
