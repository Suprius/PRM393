import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';
import '../widgets/cart_widget.dart';
import '../widgets/product_widget.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  Future<void> _clearCart(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear cart?'),
        content: const Text('Remove all products from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear cart'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      ref.read(cartControllerProvider.notifier).clear();
    }
  }

  Future<void> _checkout(BuildContext context, WidgetRef ref) async {
    final cart = ref.read(cartControllerProvider);
    if (cart.isEmpty) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm demo order'),
        content: Text(
          '${cart.itemCount} items • ${formatPrice(cart.total)}\n\n'
          'This is a demo checkout. No payment will be charged.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Place demo order'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      ref.read(cartControllerProvider.notifier).clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Demo order placed. Thank you!')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEmpty = ref.watch(
      cartControllerProvider.select((cart) => cart.isEmpty),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: productBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Clear cart',
            onPressed: isEmpty ? null : () => _clearCart(context, ref),
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: CartWidget(
          onContinueShopping: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
          onCheckout: () => _checkout(context, ref),
        ),
      ),
    );
  }
}
