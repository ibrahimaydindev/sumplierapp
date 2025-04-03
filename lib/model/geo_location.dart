class GeoLocation {
  final int id;
  final int companyCode;
  final int resellerCode;
  final int customerCode;
  final String? deviceCode;
  final int? userCode;
  final String? lat;
  final String? lang;
  final String? datetime;

  GeoLocation({
    required this.id,
    required this.companyCode,
    required this.resellerCode,
    required this.customerCode,
    this.deviceCode,
    this.userCode,
    required this.lat,
    required this.lang,
    required this.datetime,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      id: json['id'] ?? 0,
      companyCode: json['companyCode'],
      resellerCode: json['resellerCode'],
      customerCode: json['customerCode'],
      deviceCode: json['deviceCode'] ?? 0,
      userCode: json['userCode'],
      lat: json['lat'] ?? '',
      lang: json['lang'] ?? '',
      datetime: json['datetime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyCode': companyCode,
      'resellerCode': resellerCode,
      'customerCode': customerCode,
      'deviceCode': deviceCode,
      'userCode': userCode,
      'lat': lat,
      'lang': lang,
      'datetime': datetime,
    };
  }

}
