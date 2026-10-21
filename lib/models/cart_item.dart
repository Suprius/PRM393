import 'product.dart';

/// One product in the cart; adding it again increases its quantity.
class CartItem {
  const CartItem({required this.product, this.quantity = 1})
    : assert(quantity > 0);

  final Product product;
  final int quantity;

  // Round each unit to cents so totals agree with the displayed unit price.
  int get unitPriceCents => (product.discountedPrice * 100).round();
  int get originalPriceCents => (product.price * 100).round();
  int get totalCents => unitPriceCents * quantity;
  double get total => totalCents / 100;

  CartItem withQuantity(int quantity) =>
      CartItem(product: product, quantity: quantity);
}
