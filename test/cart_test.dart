import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab/dao/product_dao.dart';
import 'package:lab/main.dart';
import 'package:lab/models/product.dart';
import 'package:lab/providers/cart_provider.dart';
import 'package:lab/ui/screens/cart_page.dart';
import 'package:lab/ui/widgets/cart_item_widget.dart';

void main() {
  final products = const ProductDAO().getAllProduct();

  test('Cart merges IDs, updates quantities and keeps immutable snapshots', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(cartControllerProvider.notifier);
    controller.addProduct(products[0]);
    final snapshot = container.read(cartControllerProvider);
    controller.addProduct(products[0].copyTo());
    controller.addProduct(products[1]);
    var cart = container.read(cartControllerProvider);
    expect(cart.items, hasLength(2));
    expect(cart.itemCount, 3);
    expect(cart.totalCents, 289928);
    expect(cart.subtotalCents, 319700);
    expect(cart.savings, 297.72);
    expect(snapshot.itemCount, 1);
    expect(() => cart.items.clear(), throwsUnsupportedError);
    controller.setQuantity(products[0].id, 1);
    expect(container.read(cartControllerProvider).itemCount, 2);
    controller.setQuantity(products[0].id, 0);
    cart = container.read(cartControllerProvider);
    expect(cart.items.single.product.id, products[1].id);
    controller.removeProduct(999);
    expect(container.read(cartControllerProvider).itemCount, 1);
    controller.clear();
    expect(container.read(cartControllerProvider).totalCents, 0);
  });

  test('Totals multiply the displayed rounded unit price', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(cartControllerProvider.notifier);
    controller.addProduct(
      const Product(
        id: 99,
        name: 'Fractional discount',
        price: 0.99,
        discountPercen: 10,
      ),
    );
    controller.setQuantity(99, 3);
    expect(container.read(cartControllerProvider).totalCents, 267);
  });

  testWidgets('Cart syncs quantities and badge across product navigation', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const ValueKey(1)));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Add to Cart'));
    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    // Allow the add-to-cart feedback to dismiss before tapping underneath it.
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    expect(tester.widget<Badge>(find.byType(Badge)).label, isA<Text>());
    expect(
      find.descendant(of: find.byType(Badge), matching: find.text('2')),
      findsOneWidget,
    );
    await tester.tap(find.text('Cart'));
    await tester.pumpAndSettle();
    expect(find.byType(CartItemWidget), findsOneWidget);
    expect(find.text('Total: \$2000.18'), findsOneWidget);
    await tester.tap(find.byTooltip('Increase iPhone 13 Pro'));
    await tester.pumpAndSettle();
    expect(find.text('Total: \$3000.27'), findsOneWidget);
    await tester.tap(find.byTooltip('Decrease iPhone 13 Pro'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Decrease iPhone 13 Pro'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<IconButton>(find.widgetWithIcon(IconButton, Icons.remove))
          .onPressed,
      isNull,
    );
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: find.byType(Badge), matching: find.text('1')),
      findsOneWidget,
    );
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Total: \$1000.09'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Clear and checkout require confirmation; cancellation keeps cart',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final controller = container.read(cartControllerProvider.notifier);
      controller.addProduct(products.first);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: CartPage()),
        ),
      );
      await tester.tap(find.byTooltip('Clear cart'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(container.read(cartControllerProvider).itemCount, 1);
      await tester.ensureVisible(find.text('Checkout (demo)'));
      await tester.tap(find.text('Checkout (demo)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(container.read(cartControllerProvider).itemCount, 1);
      await tester.tap(find.text('Checkout (demo)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Place demo order'));
      await tester.pumpAndSettle();
      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Demo order placed. Thank you!'), findsOneWidget);
      expect(find.text('Checkout (demo)'), findsNothing);
      expect(
        tester
            .widget<IconButton>(
              find.widgetWithIcon(IconButton, Icons.delete_sweep_outlined),
            )
            .onPressed,
        isNull,
      );
      controller.addProduct(products.first);
      controller.addProduct(products.last);
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Clear cart'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Clear cart'));
      await tester.pumpAndSettle();
      expect(container.read(cartControllerProvider).isEmpty, isTrue);
      expect(tester.takeException(), isNull);
    },
  );

  for (final size in [const Size(320, 480), const Size(640, 320)]) {
    testWidgets('Cart scrolls at $size with enlarged text and dark theme', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      for (final product in products) {
        container.read(cartControllerProvider.notifier).addProduct(product);
      }
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(theme: ThemeData.dark(), home: const CartPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.scrollUntilVisible(find.text('Checkout (demo)'), 150);
      await tester.ensureVisible(find.text('Checkout (demo)'));
      await tester.pumpAndSettle();
      expect(find.text('Checkout (demo)').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
