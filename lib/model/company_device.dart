class CompanyDevice {
  final int id;
  final String companyCode;
  final String deviceCode;
  final String? lat;
  final String? lang;
  final String licenceCode;

  CompanyDevice({
    required this.id,
    required this.companyCode,
    required this.deviceCode,
    this.lat,
    this.lang,
    required this.licenceCode,
  });

  // Factory constructor for creating a CompanyDevice instance from JSON
  factory CompanyDevice.fromJson(Map<String, dynamic> json) {
    return CompanyDevice(
      id: json['id'],
      companyCode: json['companyCode'],
      deviceCode: json['deviceCode'],
      lat: json['lat'],
      lang: json['lang'],
      licenceCode: json['licenceCode'],
    );
  }

  // Method to convert a CompanyDevice instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyCode': companyCode,
      'deviceCode': deviceCode,
      'lat': lat,
      'lang': lang,
      'licenceCode': licenceCode,
    };
  }
}