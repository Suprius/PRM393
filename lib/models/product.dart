class Product {
  final int id;
  final String name;
  final double price;
  final double discountPercen;
  final String image;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.discountPercen = 0,
    this.image = '',
    this.description = '',
  }) : assert(price >= 0),
       assert(discountPercen >= 0 && discountPercen <= 100);

  double get discountedPrice => price * (1 - discountPercen / 100);

  Product copyTo({
    int? id,
    String? name,
    String? image,
    double? price,
    double? discountPercen,
    String? description,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    discountPercen: discountPercen ?? this.discountPercen,
    image: image ?? this.image,
    description: description ?? this.description,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: (json["price"] as num).toDouble(),
    discountPercen: (json["discountPercen"] as num?)?.toDouble() ?? 0,
    image: json["image"] as String? ?? '',
    description: json["description"] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "discountPercen": discountPercen,
    "image": image,
    "description": description,
  };
}
