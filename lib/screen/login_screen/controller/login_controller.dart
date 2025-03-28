import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../api/api_service.dart';
import '../../../model/company.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  var company = Rx<Company?>(null);
  var isLoading = false.obs;

  Future<Company?> getCompanyLogin(String email, String password) async {
    try {
      isLoading.value = true;
      company.value = await _apiService.getCompanyLogin(email, password);
    } catch (e) {
      Logger().e("controller Şirket girişi hatası: $e");
    } finally {
      isLoading.value = false;
    }
    return null;
  }
}
