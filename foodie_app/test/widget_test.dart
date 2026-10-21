import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_app/app.dart';

void main() {
  testWidgets('Home and bottom navigation are displayed', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FoodieApp()));
    await tester.pump();

    expect(find.text('Hi, Guest'), findsOneWidget);
    expect(find.text('What would you\nlike to eat?'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Popular Foods'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Foods'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('Foods tab shows every food', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FoodieApp()));
    await tester.tap(find.text('Foods'));
    await tester.pump();

    expect(find.text('All Foods'), findsOneWidget);
    expect(find.text('10 delicious choices'), findsOneWidget);
  });
}
