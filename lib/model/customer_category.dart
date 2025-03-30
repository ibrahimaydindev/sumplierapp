class CustomerCategory {
  final int id;
  final int categoryCode;
  final String categoryName;
  final bool isActive;
  final int companyCode;
  final int menuCode;

  CustomerCategory({
    required this.id,
    required this.categoryCode,
    required this.categoryName,
    required this.isActive,
    required this.companyCode,
    required this.menuCode,
  });

  // Factory constructor for creating a Category instance from JSON
  factory CustomerCategory.fromJson(Map<String, dynamic> json) {
    return CustomerCategory(
      id: json['id'],
      categoryCode: json['categoryCode'],
      categoryName: json['categoryName'],
      isActive: json['isActive'],
      companyCode: json['companyCode'],
      menuCode: json['menuCode'],
    );
  }

  // Method to convert a Category instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryCode': categoryCode,
      'categoryName': categoryName,
      'isActive': isActive,
      'companyCode': companyCode,
      'menuCode': menuCode,
    };
  }
}