class Category {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final int menuId;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.menuId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? false,
      menuId: json['menuId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
      'menuId': menuId,
    };
  }
} 