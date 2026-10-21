import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cart.dart';
import '../../providers/cart_provider.dart';
import 'cart_item_widget.dart';
import 'product_widget.dart';

/// Reusable cart content, independent of the screen's Scaffold/navigation.
class CartWidget extends ConsumerWidget {
  const CartWidget({
    super.key,
    required this.onContinueShopping,
    required this.onCheckout,
  });

  final VoidCallback onContinueShopping;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartControllerProvider);
    final controller = ref.read(cartControllerProvider.notifier);

    if (cart.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 80, color: productBlue),
              const SizedBox(height: 20),
              Text(
                'Your cart is empty',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Find something you love and add it here.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onContinueShopping,
                icon: const Icon(Icons.storefront_outlined),
                label: const Text('Continue shopping'),
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '${cart.itemCount} ${cart.itemCount == 1 ? 'item' : 'items'} in your cart',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return CartItemWidget(
                    key: ValueKey('cart-item-${item.product.id}'),
                    item: item,
                    onIncrease: () => controller.setQuantity(
                      item.product.id,
                      item.quantity + 1,
                    ),
                    onDecrease: () => controller.setQuantity(
                      item.product.id,
                      item.quantity - 1,
                    ),
                    onRemove: () => controller.removeProduct(item.product.id),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              sliver: SliverToBoxAdapter(
                child: _CartSummary(
                  cart: cart,
                  onCheckout: onCheckout,
                  onContinueShopping: onContinueShopping,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({
    required this.cart,
    required this.onCheckout,
    required this.onContinueShopping,
  });

  final Cart cart;
  final VoidCallback onCheckout;
  final VoidCallback onContinueShopping;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Order summary', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text('Subtotal: ${formatPrice(cart.subtotal)}'),
          const SizedBox(height: 8),
          Text('Savings: -${formatPrice(cart.savings)}'),
          const Divider(height: 28),
          Text(
            'Total: ${formatPrice(cart.total)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onCheckout,
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Text('Checkout (demo)'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onContinueShopping,
            child: const Text('Continue shopping'),
          ),
        ],
      ),
    ),
  );
}
