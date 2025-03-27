class Menu {
  final int id;
  final int companyCode;
  final int resellerCode;
  final int menuCode;
  final String menuName;
  final bool isActive;

  Menu({
    required this.id,
    required this.companyCode,
    required this.resellerCode,
    required this.menuCode,
    required this.menuName,
    required this.isActive,
  });

  // Factory constructor for creating a Menu instance from JSON
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      companyCode: json['companyCode'],
      resellerCode: json['resellerCode'],
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
      'menuCode': menuCode,
      'menuName': menuName,
      'isActive': isActive,
    };
  }
}