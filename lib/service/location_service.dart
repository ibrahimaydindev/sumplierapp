import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:sumplier/Config/config.dart';
import 'package:sumplier/api/api_service.dart';
import 'package:sumplier/listener/ApiMessageListener.dart';
import 'package:sumplier/model/customer.dart';
import 'package:sumplier/model/geo_location.dart';
import 'package:sumplier/model/user_model.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Timer? _timer;
  bool _isRunning = false;
  final ApiService _apiService = ApiService();

  Future<void> start() async {
    if (_isRunning) return;
    
    print('Konum servisi başlatılıyor...');
    final customer = Config.instance.getCurrentCustomer();
    final user = Config.instance.getCurrentUser();

    if (!await _checkLocationPermission()) {
      print('Konum izni reddedildi, servis başlatılamadı');
      return;
    }

    _isRunning = true;
    
    _timer = Timer.periodic(
      Duration(seconds: 30),
      (_) => _sendLocation(customer, user),
    );
  }

  void stop() {
    _timer?.cancel();
    _isRunning = false;
    print('Konum servisi durduruldu');
  }

  Future<void> _sendLocation(Customer customer, User user) async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      await _apiService.postGeoLocation(
        location: GeoLocation(
          id: 0,
          companyCode: customer.companyCode,
          resellerCode: customer.resellerCode,
          customerCode: customer.customerCode,
          deviceCode: "100",
          userCode: user.userCode,
          lat: position.latitude.toString(),
          lang: position.longitude.toString(),
          datetime: DateTime.now().toUtc().toIso8601String(),
        ),
        listener: ApiMessageListener(
          onSuccess: () => print('Konum başarıyla gönderildi'),
          onFail: (error) => print('Konum gönderilemedi: $error'),
        ),
      );
    } catch (e) {
      print('Konum gönderim hatası: $e');
    }
  }

  Future<bool> _checkLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return permission == LocationPermission.whileInUse || 
             permission == LocationPermission.always;
    }
    return permission == LocationPermission.whileInUse || 
           permission == LocationPermission.always;
  }
}