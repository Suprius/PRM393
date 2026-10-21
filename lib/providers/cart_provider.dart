import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

part 'cart_provider.g.dart';

// Keep the cart when its screen is closed. State lasts for this app session.
@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  @override
  Cart build() => Cart();

  void addProduct(Product product) {
    final existing = state.items.where((item) => item.product.id == product.id);
    if (existing.isEmpty) {
      state = Cart([...state.items, CartItem(product: product)]);
    } else {
      setQuantity(product.id, existing.first.quantity + 1);
    }
  }

  void setQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }
    state = Cart([
      for (final item in state.items)
        if (item.product.id == productId) item.withQuantity(quantity) else item,
    ]);
  }

  void removeProduct(int productId) {
    state = Cart(state.items.where((item) => item.product.id != productId));
  }

  void clear() => state = Cart();
}
