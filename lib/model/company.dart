class Company {
  final int id;
  final int companyCode;
  final String companyName;
  final bool isActive;
  final String email;
  final String password;
  final String? image;
  final int type;

  Company({
    required this.id,
    required this.companyCode,
    required this.companyName,
    required this.isActive,
    required this.email,
    required this.password,
    required this.type,
    this.image,
  });

  // Factory constructor for creating a Company instance from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyCode: json['companyCode'],
      companyName: json['companyName'],
      isActive: json['isActive'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
      type: json['type'],
    );
  }

  // Method to convert a Company instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyCode': companyCode,
      'companyName': companyName,
      'isActive': isActive,
      'email': email,
      'password': password,
      'image': image,
      'type': type,
    };
  }
}