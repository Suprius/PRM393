import 'package:flutter/material.dart';

import 'ui/screens/home_page_lab4.dart';
import 'ui/theme_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  @override
  void dispose() {
    _themeMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ThemeController(
    notifier: _themeMode,
    child: ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, mode, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lab 4 – Flutter UI Fundamentals',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: mode,
        home: const HomePageLab4(),
      ),
    ),
  );
}
