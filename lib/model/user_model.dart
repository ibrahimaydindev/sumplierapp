class User {
  final int id;
  final int userCode;
  final String name;
  final String? surname;
  final String email;
  final String password;
  final int loginType;
  final bool isActive;
  final int companyCode;
  final String roleCode;
  final int resellerCode;
  final String? image;
  final bool deleted;

  User({
    required this.id,
    required this.userCode,
    required this.name,
    this.surname,
    required this.email,
    required this.password,
    required this.loginType,
    required this.isActive,
    required this.companyCode,
    required this.roleCode,
    required this.resellerCode,
    this.image,
    required this.deleted,
  });

  // Factory constructor for creating a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userCode: json['userCode'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      loginType: json['loginType'],
      isActive: json['isActive'],
      companyCode: json['companyCode'],
      roleCode: json['roleCode'],
      resellerCode: json['resellerCode'],
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
      'roleCode': roleCode,
      'resellerCode': resellerCode,
      'image': image,
      'deleted': deleted,
    };
  }
}