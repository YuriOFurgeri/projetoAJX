class Category {
  final int id;
  final String name;
  final String image_url;

  Category({required this.id, 
  required this.name,
  required this.image_url,
   });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image_url: json['image_url'],

    );
  }
}
