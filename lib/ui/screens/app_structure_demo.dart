import 'package:flutter/material.dart';

import '../theme_controller.dart';

class AppStructureDemo extends StatelessWidget {
  const AppStructureDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeController.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure & Theme'),
        actions: [
          const Text('Dark'),
          Switch(
            value: themeMode.value == ThemeMode.dark,
            // Cập nhật MaterialApp.themeMode, áp dụng cho toàn bộ ứng dụng.
            onChanged: (dark) =>
                themeMode.value = dark ? ThemeMode.dark : ThemeMode.light,
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'This is a simple screen with theme toggle.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Show message',
        onPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Hello from Exercise 4!')),
            );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
