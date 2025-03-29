import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sumplier/Config/config.dart';
import '../../../api/api_service.dart';
import '../../../database/pref_helper.dart';
import '../../../enum/config_key.dart';
import '../../../model/company.dart';
import '../../../listener/ApiObjectListener.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  var company = Rx<Company?>(null);
  var isLoading = false.obs;

  // Giriş işlemi için listener kullanımı
  Future<void> getCompanyLogin(String email, String password) async {
    try {
      isLoading.value = true;
      await _apiService.getCompanyLogin(
        email: email,
        password: password,
        listener: ApiObjectListener<Company>(
          onSuccess: (companyData) {
            company.value = companyData;
            PrefHelper.saveModel(ConfigKey.company.name, companyData);
            Config.instance.setCurrentCompany(companyData);
          },
          onFail: (errorMessage) {
            Logger().e("Şirket girişi hatası: $errorMessage"); // Hata durumunda log yazdır
          },
        ),
      );
    } catch (e) {
      Logger().e("controller Şirket girişi hatası: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
