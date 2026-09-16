class Product{
  final String id;
  final String name;
  final String? image;
  final double price;
  final String? description;

  Product({required this.id, required this.name, this.image, required this.price, this.description});
  Product toCopy({String? id, String? name, String? image, double? price, String? description}){
    return Product(id:id??this.id,name:name??this.name,image:image??this.image,
        price:price??this.price,description:description??this.description);
  }

  //Chuyển đổi từ JSON sang đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json){
    return Product(id: (json['id']??"") as String,
        name: (json['name']??"") as String,
        image: (json['image']??"") as String,
        price: (json['price'] as num).toDouble(),
        description: (json['description']??"") as String);
  }
  //Chuyển đổi từ Product sang đối tượng JSON
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description
    };
  }
}