class User {
  final int id;
  final int companyCode;
  final int customerCode;
  final int userCode;
  final String name;
  final String? surname;
  final String email;
  final String password;
  final int loginType;
  final bool isActive;
  final int roleCode;
  final String? image;
  final bool deleted;

  User({
    required this.id,
    required this.companyCode,
    required this.customerCode,
    required this.userCode,
    required this.name,
    this.surname,
    required this.email,
    required this.password,
    required this.loginType,
    required this.isActive,
    required this.roleCode,
    this.image,
    required this.deleted,
  });

  // Factory constructor for creating a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      companyCode: json['companyCode'],
      customerCode: json['customerCode'],
      userCode: json['userCode'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      loginType: json['loginType'],
      isActive: json['isActive'],
      roleCode: json['roleCode'],
      image: json['image'],
      deleted: json['deleted'],
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userCode': userCode,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'loginType': loginType,
      'isActive': isActive,
      'companyCode': companyCode,
      'customerCode' : customerCode,
      'roleCode': roleCode,
      'image': image,
      'deleted': deleted,
    };
  }
}