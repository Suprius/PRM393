import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab/main.dart';

void main() {
  testWidgets('Exercise 4 changes app theme and the FAB shows feedback', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 4 – App Structure & Theme'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    expect(
      Theme.of(tester.element(find.byType(Switch))).brightness,
      Brightness.dark,
    );
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Hello from Exercise 4!'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Lab 4 – Flutter UI Fundamentals')))
          .brightness,
      Brightness.dark,
    );
    await tester.tap(find.text('Exercise 4 – App Structure & Theme'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
  });

  testWidgets('Exercise 5 works on a small screen with large text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const MyApp());
    await tester.scrollUntilVisible(
      find.text('Exercise 5 – Common UI Fixes'),
      150,
    );
    await tester.ensureVisible(find.text('Exercise 5 – Common UI Fixes'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Exercise 5 – Common UI Fixes'));
    await tester.pumpAndSettle();
    expect(find.text('Movie A'), findsOneWidget);
    final outer = find.byType(SingleChildScrollView);
    await tester.drag(outer, const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Increment counter'));
    await tester.tap(find.text('Increment counter'));
    await tester.pump();
    expect(find.text('Counter: 1'), findsOneWidget);
    await tester.ensureVisible(find.text('Open Date Picker'));
    await tester.tap(find.text('Open Date Picker'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Selected date: None'), findsOneWidget);
    await tester.tap(find.text('Open Date Picker'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('Selected date: None'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Exercise 3 scrolls on a small screen and returns home', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 3 – Layout Demo'));
    await tester.pumpAndSettle();
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Avatar'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Joker'), 100);
    expect(find.text('Joker').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Lab 4 – Flutter UI Fundamentals'), findsOneWidget);
  });

  testWidgets('Exercise 1 opens the core widgets and returns home', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 1 – Core Widgets Demo'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to Flutter UI'), findsOneWidget);
    expect(find.byIcon(Icons.movie), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Movie Item'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Lab 4 – Flutter UI Fundamentals'), findsOneWidget);
  });

  testWidgets(
    'Exercise 2 updates controls and handles date confirmation/cancel',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Exercise 2 – Input Controls Demo'));
      await tester.pumpAndSettle();
      expect(find.text('Current value: 50'), findsOneWidget);
      await tester.drag(find.byType(Slider), const Offset(150, 0));
      await tester.pumpAndSettle();
      expect(find.text('Current value: 50'), findsNothing);
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(find.text('Active: Yes'), findsOneWidget);
      await tester.tap(find.text('Action'));
      await tester.pumpAndSettle();
      expect(find.text('Selected genre: Action'), findsOneWidget);
      await tester.tap(find.text('Comedy'));
      await tester.pumpAndSettle();
      expect(find.text('Selected genre: Comedy'), findsOneWidget);
      await tester.ensureVisible(find.text('Open Date Picker'));
      await tester.tap(find.text('Open Date Picker'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Selected date: None'), findsOneWidget);
      await tester.tap(find.text('Open Date Picker'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.text('Selected date: None'), findsNothing);
      final selected = tester
          .widget<Text>(find.textContaining('Selected date:'))
          .data;
      await tester.tap(find.text('Open Date Picker'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text(selected!), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
