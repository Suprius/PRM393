class Product {
  final String id;
  final String name;
  final double price;
  final String? image;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.description,
  });

  Product copyTo({
    String? id,
    String? name,
    double? price,
    String? image,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: "$name", price: $price, image: $image, description: $description)';
  }
}

void main() {
  const p1 = Product(
    id: "P01",
    name: "Xiaomi Redmi Note 8",
    price: 999.99,
    description: "Phiên bản tiêu chuẩn",
  );

  print("--- San pham ban dau ---");
  print(p1);

  Product p2 = p1.copyTo(
    name: "Xiaomi Redmi Note 8 Pro",
    price: 1199.99,
    image: "https://example.com/XiaomiRedmiNote8Pro.png",
  );

  print("\n--- San pham sau khi copyTo (chỉnh sửa) ---");
  print(p2);

  print("\n--- Kiem tra lai p1 ---");
  print(p1);
}