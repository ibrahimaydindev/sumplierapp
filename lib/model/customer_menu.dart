class CustomerMenu {
  final int id;
  final int companyCode;
  final int resellerCode;
  final int customerCode;
  final int menuCode;
  final String menuName;
  final bool isActive;

  CustomerMenu({
    required this.id,
    required this.companyCode,
    required this.resellerCode,
    required this.customerCode,
    required this.menuCode,
    required this.menuName,
    required this.isActive,
  });

  // Factory constructor for creating a Menu instance from JSON
  factory CustomerMenu.fromJson(Map<String, dynamic> json) {
    return CustomerMenu(
      id: json['id'],
      companyCode: json['companyCode'],
      resellerCode: json['resellerCode'],
      customerCode: json['customerCode'],
      menuCode: json['menuCode'],
      menuName: json['menuName'],
      isActive: json['isActive'],
    );
  }

  // Method to convert a Menu instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyCode': companyCode,
      'resellerCode': resellerCode,
      'customerCode': customerCode,
      'menuCode': menuCode,
      'menuName': menuName,
      'isActive': isActive,
    };
  }
}