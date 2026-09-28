import '../models/product.dart';

/// Local sample data; no server or network connection is needed.
class ProductDAO {
  const ProductDAO();

  static const List<Product> _products = [
    Product(
      id: 1,
      name: 'iPhone 13 Pro',
      description:
          'Discover the iPhone 13 Pro with its bright Super Retina XDR '
          'display, A15 Bionic chip and versatile triple-camera system. '
          'Capture beautiful photos and enjoy smooth everyday performance.',
      price: 1099,
      discountPercen: 9,
      image: 'assets/products/iphone-13-pro.webp',
    ),
    Product(
      id: 2,
      name: 'Samsung Galaxy S10',
      description:
          'Enjoy a vivid Dynamic AMOLED display, a versatile camera '
          'system and a comfortable, slim design. The Samsung Galaxy S10 '
          'keeps your favorite apps, photos and entertainment close at hand.',
      price: 999,
      discountPercen: 10,
      image: 'assets/products/samsung-galaxy-s10.webp',
    ),
    Product(
      id: 3,
      name: 'MacBook Pro',
      description:
          'Create, study and work on a beautiful 14-inch display. '
          'MacBook Pro combines a comfortable keyboard, powerful performance '
          'and a portable aluminum design for your everyday projects.',
      price: 1299,
      discountPercen: 7,
      image: 'assets/products/macbook-pro.webp',
    ),
  ];

  List<Product> getAllProduct() => List.unmodifiable(_products);

  /// Matches any part of the name, ignoring case and surrounding spaces.
  /// An empty query returns the whole catalog.
  List<Product> findProductByName(String name) {
    final query = name.trim().toLowerCase();
    return List.unmodifiable(
      _products.where((product) => product.name.toLowerCase().contains(query)),
    );
  }
}
