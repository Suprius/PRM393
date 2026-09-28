import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../widgets/product_widget.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onOpenCart,
  });

  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onOpenCart;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Product Detail'),
      centerTitle: true,
      backgroundColor: productBlue,
      foregroundColor: Colors.white,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ProductImage(product: product),
                ),
                const SizedBox(height: 24),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ProductPrice(product: product, large: true),
                    if (product.discountPercen > 0)
                      DiscountBadge(product: product),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16, height: 1.6),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: productBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: onAddToCart,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    bottomNavigationBar: ProductNavigationBar(
      currentIndex: 1,
      onTap: (index) {
        if (index == 0) Navigator.of(context).pop();
        if (index == 2) onOpenCart();
      },
    ),
  );
}

class ProductNavigationBar extends StatelessWidget {
  const ProductNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    selectedItemColor: productBlue,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(Icons.article_outlined),
        label: 'Product Detail',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
    ],
  );
}
