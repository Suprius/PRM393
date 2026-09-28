import 'package:flutter/material.dart';

import '../../dao/product_dao.dart';
import '../../models/product.dart';
import '../widgets/product_widget.dart';
import 'home_page_lab4.dart';
import 'product_detail_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _dao = const ProductDAO();
  final _search = TextEditingController();
  final List<Product> _cart = [];
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
            _cart.add(product);
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
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => StatefulBuilder(
        builder: (context, updateCart) => Column(
          children: [
            Text('Cart', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Expanded(
              child: _cart.isEmpty
                  ? const Center(child: Text('Your cart is empty'))
                  : ListView.builder(
                      itemCount: _cart.length,
                      itemBuilder: (context, index) {
                        final product = _cart[index];
                        return ListTile(
                          leading: SizedBox(
                            width: 48,
                            child: ProductImage(product: product),
                          ),
                          title: Text(product.name),
                          subtitle: Text(formatPrice(product.discountedPrice)),
                          trailing: IconButton(
                            tooltip: 'Remove ${product.name}',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () =>
                                updateCart(() => _cart.removeAt(index)),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Total: ${formatPrice(_cart.fold<double>(0, (sum, product) => sum + product.discountedPrice))}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
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
