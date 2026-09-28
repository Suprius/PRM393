import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab/dao/product_dao.dart';
import 'package:lab/main.dart';
import 'package:lab/models/product.dart';
import 'package:lab/ui/screens/product_detail_page.dart';
import 'package:lab/ui/screens/products_page.dart';
import 'package:lab/ui/widgets/product_widget.dart';

void main() {
  const dao = ProductDAO();

  test(
    'DAO searches case-insensitively, trims input and handles no matches',
    () {
      expect(dao.getAllProduct(), hasLength(3));
      expect(dao.findProductByName('  IPHONE  ').single.id, 1);
      expect(dao.findProductByName('galaxy').single.id, 2);
      expect(dao.findProductByName('  '), hasLength(3));
      expect(dao.findProductByName('unknown'), isEmpty);
      expect(() => dao.getAllProduct().clear(), throwsUnsupportedError);
    },
  );

  test(
    'Product calculates discount and preserves fields across JSON and copy',
    () {
      final product = Product.fromJson({
        'id': 9,
        'name': 'Test',
        'price': 200,
        'discountPercen': 10,
        'description': 'Description',
        'image': 'image.webp',
      });
      expect(product.discountedPrice, 180);
      expect(Product.fromJson(product.toJson()).toJson(), product.toJson());
      expect(product.copyTo(name: 'Changed').discountPercen, 10);
      expect(product.copyTo(discountPercen: 0).discountedPrice, 200);
      expect(product.copyTo(discountPercen: 100).discountedPrice, 0);
    },
  );

  for (final entry in <(Size, int)>[
    (const Size(320, 640), 1),
    (const Size(499, 800), 1),
    (const Size(500, 800), 1),
    (const Size(501, 800), 2),
    (const Size(768, 1024), 2),
    (const Size(480, 320), 2),
    (const Size(500, 320), 2),
    (const Size(501, 320), 3),
    (const Size(900, 600), 3),
  ]) {
    testWidgets('${entry.$1} uses ${entry.$2} columns without overflow', (
      tester,
    ) async {
      tester.view.physicalSize = entry.$1;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, entry.$2);
      final width = tester.getSize(find.byType(ProductWidget).first).width;
      expect(
        width,
        closeTo((entry.$1.width - 24 - 12 * (entry.$2 - 1)) / entry.$2, 0.01),
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Grid uses parent width even inside a larger landscape screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(
        home: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(width: 450, child: ProductsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final grid = tester.widget<GridView>(find.byType(GridView));
    expect(
      (grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount)
          .crossAxisCount,
      2,
    );
    expect(tester.getSize(find.byType(ProductWidget).first).width, 207);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Search, empty state, clear, details and return preserve query', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField), 'galaxy');
    await tester.pumpAndSettle();
    expect(find.byType(ProductWidget), findsOneWidget);
    await tester.tap(find.byType(ProductWidget));
    await tester.pumpAndSettle();
    expect(find.byType(ProductDetailPage), findsOneWidget);
    expect(find.text(dao.getAllProduct()[1].description), findsOneWidget);
    expect(tester.widget<Image>(find.byType(Image)).image, isA<AssetImage>());
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'galaxy',
    );
    await tester.enterText(find.byType(TextField), 'missing');
    await tester.pump();
    expect(find.text('No products found. Try another name.'), findsOneWidget);
    await tester.tap(find.byTooltip('Clear search'));
    await tester.pumpAndSettle();
    expect(find.byType(ProductWidget), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Every card opens its own image, name and description', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    for (final product in dao.getAllProduct()) {
      await tester.tap(find.byKey(ValueKey(product.id)));
      await tester.pumpAndSettle();
      expect(find.text(product.name), findsOneWidget);
      expect(find.text(product.description), findsOneWidget);
      expect(
        (tester.widget<Image>(find.byType(Image)).image as AssetImage)
            .assetName,
        product.image,
      );
      await tester.pageBack();
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Cart adds and removes the selected product', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const ValueKey(1)));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Add to Cart'));
    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Total: \$1000.09'), findsOneWidget);
    await tester.tap(find.byTooltip('Remove iPhone 13 Pro'));
    await tester.pumpAndSettle();
    expect(find.text('Your cart is empty'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Small screen with enlarged text scrolls through details', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.byKey(const ValueKey(1)));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Add to Cart').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
