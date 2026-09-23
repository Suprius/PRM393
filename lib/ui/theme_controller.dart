import 'package:flutter/material.dart';

// Đặt phía trên MaterialApp để các route cùng dùng một themeMode.
class ThemeController extends InheritedNotifier<ValueNotifier<ThemeMode>> {
  const ThemeController({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ValueNotifier<ThemeMode> of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeController>()!.notifier!;
}
