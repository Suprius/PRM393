import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Screens/post_page.dart';
import '../../dao/product_dao.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../widgets/product_widget.dart';
import 'home_page_lab4.dart';
import 'product_detail_page.dart';
import 'cart_page.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  final _dao = const ProductDAO();
  final _search = TextEditingController();
  late List<Product> _products = _dao.getAllProduct();
  Product? _selectedProduct;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _filter(String query) {
    setState(() => _products = _dao.findProductByName(query));
  }

  void _openProduct(Product product) {
    _selectedProduct = product;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (detailContext) => ProductDetailPage(
          product: product,
          onAddToCart: () {
            ref.read(cartControllerProvider.notifier).addProduct(product);
            ScaffoldMessenger.of(detailContext)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('${product.name} added to cart')),
              );
          },
          onOpenCart: () => _openCart(detailContext),
        ),
      ),
    );
  }

  void _openCart(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const CartPage()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF191B20)
        : const Color(0xFFF0F0F5),
    appBar: AppBar(
      title: const Text('Products'),
      centerTitle: true,
      backgroundColor: productBlue,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          tooltip: 'Posts',
          icon: const Icon(Icons.article_outlined),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (_) => const PostPage())),
        ),
        IconButton(
          tooltip: 'Lab 4 exercises',
          icon: const Icon(Icons.school_outlined),
          onPressed: () => Navigator.of(
            context,
          ).push(MaterialPageRoute<void>(builder: (_) => const HomePageLab4())),
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _search,
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _search.clear();
                          _filter('');
                        },
                      ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Width comes from the parent; orientation from the screen.
                // Exactly 500 belongs to the <=500 group in the assignment.
                final compact = constraints.maxWidth <= 500;
                final portrait =
                    MediaQuery.orientationOf(context) == Orientation.portrait;
                final columns = compact
                    ? (portrait ? 1 : 2)
                    : (portrait ? 2 : 3);
                final textScale =
                    MediaQuery.textScalerOf(context).scale(14) / 14;

                if (_products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No products found. Try another name.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 150 * textScale.clamp(1.0, 3.0),
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) => ProductWidget(
                    key: ValueKey(_products[index].id),
                    product: _products[index],
                    onTap: () => _openProduct(_products[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: ProductNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) {
          final selected = _selectedProduct;
          if (selected != null) {
            _openProduct(selected);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tap a product to view its details'),
              ),
            );
          }
        } else if (index == 2) {
          _openCart(context);
        }
      },
    ),
  );
}
