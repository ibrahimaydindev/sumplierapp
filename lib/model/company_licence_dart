class CompanyLicence {
  final int id;
  final String companyCode;
  final String licenceCode;
  final String startDateTime;
  final String endDateTime;

  CompanyLicence({
    required this.id,
    required this.companyCode,
    required this.licenceCode,
    required this.startDateTime,
    required this.endDateTime,
  });

  // Factory constructor for creating a CompanyLicence instance from JSON
  factory CompanyLicence.fromJson(Map<String, dynamic> json) {
    return CompanyLicence(
      id: json['id'],
      companyCode: json['companyCode'],
      licenceCode: json['licenceCode'],
      startDateTime: json['startDateTime'],
      endDateTime: json['endDateTime'],
    );
  }

  // Method to convert a CompanyLicence instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyCode': companyCode,
      'licenceCode': licenceCode,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
    };
  }
}