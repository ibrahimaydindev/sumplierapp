class Customer {
  final int id;
  final int companyCode;
  final int resellerCode;
  final int customerCode;
  final String customerName;
  final int customerType;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String taxOffice;
  final String taxNumber;
  final bool isActive;

  Customer({
    required this.id,
    required this.companyCode,
    required this.resellerCode,
    required this.customerCode,
    required this.customerName,
    required this.customerType,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.taxOffice,
    required this.taxNumber,
    required this.isActive,
  });
  
  // Factory constructor for creating a Customer instance from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      companyCode: json['companyCode'],
      resellerCode: json['resellerCode'],
      customerCode: json['customerCode'],
      customerName: json['customerName'],
      customerType: json['customerType'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      taxOffice: json['taxOffice'],
      taxNumber: json['taxNumber'],
      isActive: json['isActive'],
    );
  }

  // Method to convert a Customer instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyCode': companyCode,
      'resellerCode': resellerCode,
      'customerCode': customerCode,
      'customerName': customerName,
      'customerType': customerType,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'taxOffice': taxOffice,
      'taxNumber': taxNumber,
      'isActive': isActive,
    };
  }

}