import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab/main.dart';

void main() {
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
