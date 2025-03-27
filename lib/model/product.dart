class Product {
  final int id;
  final int categoryCode;
  int resellerCode;
  final int productCode;
  final String productName;
  final double price;
  String? barcode;
  final double price2;
  final double price3;
  final double taxRate;
  final double taxRate2;
  final double taxRate3;
  final String? image;
  final String? description;
  final bool isActive;
  final int companyCode;

  Product({
    required this.id,
    required this.categoryCode,
    required this.resellerCode,
    required this.productCode,
    required this.productName,
    required this.price,
    this.barcode,
    required this.price2,
    required this.price3,
    required this.taxRate,
    required this.taxRate2,
    required this.taxRate3,
    this.image,
    this.description,
    required this.isActive,
    required this.companyCode,
  });

  // Factory constructor for creating a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryCode: json['categoryCode'],
      resellerCode: json['resellerCode'],
      productCode: json['productCode'],
      productName: json['productName'],
      price: json['price'],
      barcode: json['barcode'],
      price2: json['price2'],
      price3: json['price3'],
      taxRate: json['taxRate'],
      taxRate2: json['taxRate2'],
      taxRate3: json['taxRate3'],
      image: json['image'],
      description: json['description'],
      isActive: json['isActive'],
      companyCode: json['companyCode'],
    );
  }

  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryCode': categoryCode,
      'resellerCode': resellerCode,
      'productCode': productCode,
      'productName': productName,
      'price': price,
      'barcode': barcode,
      'price2': price2,
      'price3': price3,
      'taxRate': taxRate,
      'taxRate2': taxRate2,
      'taxRate3': taxRate3,
      'image': image,
      'description': description,
      'isActive': isActive,
      'companyCode': companyCode,
    };
  }
}