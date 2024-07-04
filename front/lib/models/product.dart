class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image_url;
  final int category_id;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image_url,
    required this.category_id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image_url: json['image_url'],
      category_id: json['category_id'],
    );
  }
}
