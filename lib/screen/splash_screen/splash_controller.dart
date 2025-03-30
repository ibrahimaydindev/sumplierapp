import 'package:get/get.dart';
import 'package:sumplier/Config/config.dart';
import 'package:sumplier/model/customer.dart';
import 'package:sumplier/screen/dashboard_screen/view/dashboard_page.dart';
import '../../api/api_service.dart';
import '../../listener/ApiListListener.dart';
import '../../model/customer_category.dart';
import '../../model/customer_account.dart';
import '../../model/customer_menu.dart';
import '../../model/customer_product.dart';
import '../../model/user_model.dart';

class SplashController extends GetxController {
  final ApiService _apiService = ApiService();

  List<CustomerMenu> menus = [];
  List<CustomerCategory> categories = [];
  List<CustomerProduct> products = [];
  List<CustomerAccount> companyAccounts = [];

  Customer currentCustomer = Config.instance.getCurrentCustomer();
  User currentUser = Config.instance.getCurrentUser();

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    fetchMenus();
  }

  void fetchMenus() {
    _apiService.fetchMenus(
      companyCode: currentCustomer.companyCode,
      resellerCode: currentCustomer.resellerCode,
      customerCode: currentCustomer.customerCode,
      listener: ApiListListener<CustomerMenu>(
        onSuccess: (data) {
          menus = data;
          print("Menüler yüklendi: ${menus.length}");
          fetchCategories();
        },
        onFail: (error) {
          print("Menüleri çekerken hata oluştu: $error");
        },
      ),
    );
  }

  void fetchCategories() {
    _apiService.fetchCategories(
      companyCode: currentCustomer.companyCode,
      resellerCode: currentCustomer.resellerCode,
      customerCode: currentCustomer.customerCode,
      listener: ApiListListener<CustomerCategory>(
        onSuccess: (data) {
          categories = data;
          print("Kategoriler yüklendi: ${categories.length}");
          fetchProducts();
        },
        onFail: (error) {
          print("Kategorileri çekerken hata oluştu: $error");
        },
      ),
    );
  }

  void fetchProducts() {
    _apiService.fetchProducts(
      companyCode: currentCustomer.companyCode,
      resellerCode: currentCustomer.resellerCode,
      customerCode: currentCustomer.customerCode,
      listener: ApiListListener<CustomerProduct>(
        onSuccess: (data) {
          products = data;
          print("Ürünler yüklendi: ${products.length}");
          fetchCompanyAccounts();
        },
        onFail: (error) {
          print("Ürünleri çekerken hata oluştu: $error");
        },
      ),
    );
  }

  void fetchCompanyAccounts() {
    _apiService.fetchCompanyAccounts(
      companyCode: currentCustomer.companyCode,
      resellerCode: currentCustomer.resellerCode,
      customerCode: currentCustomer.customerCode,
      listener: ApiListListener<CustomerAccount>(
        onSuccess: (data) {
          companyAccounts = data;
          print("Accounts yüklendi: ${companyAccounts.length}");
          startApp();
        },
        onFail: (error) {
          print("Accounts çekerken hata oluştu: $error");
        },
      ),
    );
  }

  void startApp() {
    print("Tüm API çağrıları tamamlandı. Uygulama başlatılıyor...");

    Config.instance.checkSetMenus(menus);
    Config.instance.checkSetCategories(categories);
    Config.instance.checkSetProducts(products);
    Config.instance.checkSetCompanyAccounts(companyAccounts);

    isLoading.value = false;
    Get.to(() => DashboardPage());
  }
}
