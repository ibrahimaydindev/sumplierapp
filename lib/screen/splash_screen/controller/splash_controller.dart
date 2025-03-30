import 'package:get/get.dart';
import 'package:sumplier/Config/config.dart';
import 'package:sumplier/model/customer.dart';
import '../../../api/api_service.dart';
import '../../../listener/ApiListListener.dart';
import '../../../model/customer_category.dart';
import '../../../model/customer_account.dart';
import '../../../model/customer_menu.dart';
import '../../../model/customer_product.dart';
import '../../../model/user_model.dart';
import 'package:flutter/material.dart';

class SplashController extends GetxController {
  late final ApiService _apiService;

  List<CustomerMenu> menus = [];
  List<CustomerCategory> categories = [];
  List<CustomerProduct> products = [];
  List<CustomerAccount> companyAccounts = [];

  Customer currentCustomer = Config.instance.getCurrentCustomer();
  User currentUser = Config.instance.getCurrentUser();

  final isLoading = true.obs;
  final progress = 0.0.obs;
  final currentLoadingText = "Yükleniyor...".obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.put(ApiService());
    loadAllData();
  }

  Future<void> loadAllData() async {
    try {
      // Menüleri yükle
      currentLoadingText.value = "Menüler yükleniyor...";
      await _apiService.fetchMenus(
        companyCode: Config.instance.getCurrentCustomer().companyCode,
        resellerCode: Config.instance.getCurrentCustomer().resellerCode,
        customerCode: Config.instance.getCurrentCustomer().customerCode,
        listener: ApiListListener<CustomerMenu>(
          onSuccess: (data) {
            menus = data;
          },
          onFail: (error) {
          },
        ),
      );
      progress.value = 0.25;

      // Kategorileri yükle
      currentLoadingText.value = "Kategoriler yükleniyor...";
      await _apiService.fetchCategories(
        companyCode: Config.instance.getCurrentCustomer().companyCode,
        resellerCode: Config.instance.getCurrentCustomer().resellerCode,
        customerCode: Config.instance.getCurrentCustomer().customerCode,
        listener: ApiListListener<CustomerCategory>(
          onSuccess: (data) {
            categories = data;
          },
          onFail: (error) {
          },
        ),
      );
      progress.value = 0.5;

      // Ürünleri yükle
      currentLoadingText.value = "Ürünler yükleniyor...";
      await _apiService.fetchProducts(
        companyCode: Config.instance.getCurrentCustomer().companyCode,
        resellerCode: Config.instance.getCurrentCustomer().resellerCode,
        customerCode: Config.instance.getCurrentCustomer().customerCode,
        listener: ApiListListener<CustomerProduct>(
          onSuccess: (data) {
            products = data;
          },
          onFail: (error) {
          },
        ),
      );
      progress.value = 0.75;

      // Company Accountları yükle
      currentLoadingText.value = "Şirket hesapları yükleniyor...";
      await _apiService.fetchCompanyAccounts(
        companyCode: Config.instance.getCurrentCustomer().companyCode,
        resellerCode: Config.instance.getCurrentCustomer().resellerCode,
        customerCode: Config.instance.getCurrentCustomer().customerCode,
        listener: ApiListListener<CustomerAccount>(
          onSuccess: (data) {
            companyAccounts = data;
          },
          onFail: (error) {
          },
        ),
      );
      progress.value = 1.0;

      // Yükleme tamamlandı
      currentLoadingText.value = "Yükleme tamamlandı!";
      
      // Config'e verileri kaydet
      Config.instance.checkSetMenus(menus);
      Config.instance.checkSetCategories(categories);
      Config.instance.checkSetProducts(products);
      Config.instance.checkSetCompanyAccounts(companyAccounts);

      // 2 saniye bekleyip login sayfasına yönlendir
      await Future.delayed(Duration(seconds: 2));
      Get.offAllNamed('/DashboardPage');
      
    } catch (e) {
      currentLoadingText.value = "Hata oluştu: ${e.toString()}";
      Get.snackbar(
        "Hata",
        "Veri yüklenirken bir hata oluştu",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
