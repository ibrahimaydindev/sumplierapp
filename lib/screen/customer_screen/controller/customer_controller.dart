import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sumplier/Config/config.dart';
import 'package:sumplier/model/customer.dart';
import '../../../api/api_service.dart';
import '../../../database/pref_helper.dart';
import '../../../enum/config_key.dart';
import '../../../listener/ApiObjectListener.dart';

class CustomerController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var customer = Rx<Customer?>(null);
  var isLoading = false.obs;

  // Giriş işlemi için listener kullanımı
  Future<void> getCustomerLogin(String email, String password) async {
    try {
      isLoading.value = true;
      await _apiService.getCustomerLogin(
        email: email,
        password: password,
        listener: ApiObjectListener<Customer>(
          onSuccess: (customerData) {
            customer.value = customerData;
            PrefHelper.saveModel(ConfigKey.customer.name, customerData);
            Config.instance.setCurrentCompany(customerData);
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
