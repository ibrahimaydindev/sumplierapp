import 'package:get/get.dart';
import 'package:sumplier/service/location_service.dart';

class DashboardController extends GetxController {
  final LocationService _locationService = LocationService();

  @override
  void onInit() {
    super.onInit();
    _locationService.start();
  }

  @override
  void onClose() {
    _locationService.stop();
    super.onClose();
  }
}