import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sumplier/api/api_service.dart';
import 'package:sumplier/database/pref_helper.dart';
import '../../../Config/config.dart';
import '../../../enum/config_key.dart';
import '../../../model/user_model.dart';
import '../../../listener/ApiObjectListener.dart'; // ApiObjectListener import edilmelidir

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  var user = Rx<User?>(null);
  var isLoading = false.obs;
  var rememberMe = false.obs; // "Beni Hatırla" durumu

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> getUserLogin(String email, String password) async {
    try {
      isLoading.value = true;
      await _apiService.getUserLogin(
        email: email,
        password: password,
        listener: ApiObjectListener<User>(
          onSuccess: (userData) {
            user.value = userData;
            PrefHelper.saveModel(ConfigKey.user.name, userData);
            Config.instance.setCurrentUser(userData);
          },
          onFail: (errorMessage) {
            Logger().e("Şirket girişi hatası: $errorMessage");
          },
        ),
      );
    } catch (e) {
      Logger().e("controller Kullanıcı girişi hatası: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
