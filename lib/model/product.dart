class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final bool isActive;
  final int categoryId;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isActive,
    required this.categoryId,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      isActive: json['isActive'] ?? false,
      categoryId: json['categoryId'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'isActive': isActive,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
    };
  }
} 