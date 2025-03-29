import 'package:get/get.dart';
import 'package:sumplier/Config/config.dart';
import '../../api/api_service.dart';
import '../../listener/ApiListListener.dart';
import '../../model/category.dart';
import '../../model/company.dart';
import '../../model/company_account.dart';
import '../../model/menu.dart';
import '../../model/product.dart';
import '../../model/user_model.dart';

class SplashController extends GetxController {
  final ApiService _apiService = ApiService();

  List<Menu> menus = [];
  List<Category> categories = [];
  List<Product> products = [];
  List<CompanyAccount> companyAccounts = [];

  Company currentCompany = Config.instance.getCurrentCompany();
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
      companyCode: currentCompany.companyCode,
      resellerCode: currentUser.id,
      listener: ApiListListener<Menu>(
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
      companyCode: 1,
      resellerCode: 100,
      listener: ApiListListener<Category>(
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
      companyCode: 1,
      resellerCode: 100,
      listener: ApiListListener<Product>(
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
      companyCode: 1,
      resellerCode: 100,
      listener: ApiListListener<CompanyAccount>(
        onSuccess: (data) {
          companyAccounts = data;
          print("Accounts yüklendi: ${companyAccounts.length}");
          fetchCompanyAccounts();
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
    Get.offNamed('/home');
  }
}
