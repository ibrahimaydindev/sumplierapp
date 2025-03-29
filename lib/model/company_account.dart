class CompanyAccount {
  final int id;
  final int accountCode;
  final String accountName;
  final String? address;
  final String? region;
  final String? city;
  String? taxNumber;
  String? taxOffice;
  final bool isActive;
  final int companyCode;
  int resellerCode;
  String? phoneNumber;

  CompanyAccount({
    required this.id,
    required this.accountCode,
    required this.accountName,
    this.address,
    this.region,
    this.city,
    this.taxNumber,
    this.taxOffice,
    required this.isActive,
    required this.companyCode,
    required this.resellerCode,
    this.phoneNumber,
  });

  // Factory constructor for creating a CompanyAccount instance from JSON
  factory CompanyAccount.fromJson(Map<String, dynamic> json) {
    return CompanyAccount(
      id: json['id'],
      accountCode: json['accountCode'],
      accountName: json['accountName'],
      address: json['address'],
      region: json['region'],
      city: json['city'],
      taxNumber: json['taxNumber'],
      taxOffice: json['taxOffice'],
      isActive: json['isActive'],
      companyCode: json['companyCode'],
      resellerCode: json['resellerCode'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Method to convert a CompanyAccount instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountCode': accountCode,
      'accountName': accountName,
      'address': address,
      'region': region,
      'city': city,
      'taxNumber': taxNumber,
      'taxOffice': taxOffice,
      'isActive': isActive,
      'companyCode': companyCode,
      'resellerCode': resellerCode,
      'phoneNumber': phoneNumber,
    };
  }
}