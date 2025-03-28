import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sumplier/api/api_service.dart';
import 'package:sumplier/database/pref_helper.dart';
import '../../../model/user_model.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  var user = Rx<User?>(null);
  var isLoading = false.obs;
  var rememberMe = false.obs; // "Beni Hatırla" durumu

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Kullanıcı bilgilerini kaydet
  Future<void> saveCredentials(String email, String password) async {
    if (rememberMe.value) {
      await PrefHelper.saveModel('saved_email', email);
      await PrefHelper.saveModel('saved_password', password);
      await PrefHelper.saveModel('remember_me', true);
    } else {
      await PrefHelper.remove('saved_email');
      await PrefHelper.remove('saved_password');
      await PrefHelper.saveModel('remember_me', false);
    }
  }

  // Kullanıcı bilgilerini yükle
  Future<void> loadSavedCredentials() async {
    emailController.text = PrefHelper.getString('saved_email') ?? '';
    passwordController.text = PrefHelper.getString('saved_password') ?? '';
    rememberMe.value = PrefHelper.getBool('remember_me') ?? false;
  }

  // Kullanıcı giriş işlemi
  Future<User?> getUserLogin(String email, String password) async {
    try {
      isLoading.value = true;
      user.value = await _apiService.getUserLogin(email, password);

      // Eğer giriş başarılıysa ve "Beni Hatırla" seçiliyse bilgileri kaydet
      if (user.value != null) {
        await saveCredentials(email, password);
        await PrefHelper.saveModel('user', user.value!);
      }
    } catch (e) {
      Logger().e("$e");
    } finally {
      isLoading.value = false;
    }
    return user.value;
  }
}