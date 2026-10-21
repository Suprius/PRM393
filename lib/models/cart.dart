import 'cart_item.dart';

class Cart {
  Cart([Iterable<CartItem> items = const []])
    : items = List.unmodifiable(items);

  final List<CartItem> items;

  bool get isEmpty => items.isEmpty;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  int get subtotalCents => items.fold(
    0,
    (sum, item) => sum + item.originalPriceCents * item.quantity,
  );
  int get totalCents => items.fold(0, (sum, item) => sum + item.totalCents);
  double get subtotal => subtotalCents / 100;
  double get savings => (subtotalCents - totalCents) / 100;
  double get total => totalCents / 100;
}
