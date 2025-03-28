import 'package:get/get.dart';
import '../../api/api_service.dart';
import '../../listener/ApiListListener.dart';
import '../../listener/ApiObjectListener.dart';
import '../../model/category.dart';
import '../../model/company_account.dart';
import '../../model/menu.dart';
import '../../model/product.dart';

class SplashController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  List<Menu> menus = [];
  List<Category> categories = [];
  List<Product> products = [];
  List<CompanyAccount> companyAccounts = [];

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
      companyCode: 1,
      resellerCode: 100,
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
      listener: ApiObjectListener<CompanyAccount>(
        onSuccess: (data) {
          companyAccounts.add(data); // Single account added to the list
          print("Hesap yüklendi: ${companyAccounts.length}");
          startApp();
        },
        onFail: (error) {
          print("Hesapları çekerken hata oluştu: $error");
        },
      ),
    );
  }

  void startApp() {
    print("Tüm API çağrıları tamamlandı. Uygulama başlatılıyor...");
    Get.offNamed('/home'); // Ana ekrana yönlendirme
  }
}
