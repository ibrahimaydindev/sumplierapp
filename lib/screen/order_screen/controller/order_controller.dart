import 'package:get/get.dart';
import 'package:sumplier/Config/config.dart';
import 'package:sumplier/model/customer_menu.dart';
import 'package:sumplier/model/customer_product.dart';
import 'package:sumplier/model/customer_category.dart';

class OrderController extends GetxController {
  // Menü listesi
  final menus = <CustomerMenu>[].obs;
  // Seçili menü
  final selectedMenu = Rxn<CustomerMenu>();
  // Kategori listesi
  final categories = <CustomerCategory>[].obs;
  // Ürün listesi
  final products = <CustomerProduct>[].obs;
  // Seçili kategori
  final selectedCategory = Rxn<CustomerCategory>();
  
  // Yükleme durumu
  final isLoading = false.obs;
  
  // Sepet işlemleri için
  final selectedProducts = <CustomerProduct, int>{}.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadMenus();
  }

  // Menüleri yükle
  void loadMenus() {
    try {
      final menuList = Config.instance.getMenus();
      if (menuList.isNotEmpty) {
        menus.value = menuList;
        selectedMenu.value = menus.first;
        loadCategoriesForMenu(menus.first.menuCode);
      }
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Menüler yüklenirken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Seçili menüye göre kategorileri yükle
  void loadCategoriesForMenu(int menuCode) {
    try {
      final categoryList = Config.instance.getCategories();
      if (categoryList.isNotEmpty) {
        categories.value = categoryList
            .where((category) => category.menuCode == menuCode)
            .toList();
        
        if (categories.isNotEmpty) {
          selectedCategory.value = categories.first;
          loadProductsForCategory(categories.first.categoryCode);
        } else {
          products.clear();
          selectedCategory.value = null;
        }
      }
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Kategoriler yüklenirken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Seçili kategoriye göre ürünleri yükle
  void loadProductsForCategory(int categoryCode) {
    try {
      final productList = Config.instance.getProducts();
      if (productList.isNotEmpty) {
        products.value = productList
            .where((product) => product.categoryCode == categoryCode)
            .toList();
      } else {
        products.clear();
      }
    } catch (e) {
      print('Ürün yükleme hatası: $e');
      Get.snackbar(
        'Hata',
        'Ürünler yüklenirken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Menü seçildiğinde
  void onMenuSelected(CustomerMenu menu) {
    selectedMenu.value = menu;
    loadCategoriesForMenu(menu.menuCode);
    }

  // Kategori seçildiğinde
  void onCategorySelected(CustomerCategory category) {
    selectedCategory.value = category;
    loadProductsForCategory(category.categoryCode);
    update();
    }

  // Sepet işlemleri
  void addToCart(CustomerProduct product) {
    if (selectedProducts.containsKey(product)) {
      selectedProducts[product] = (selectedProducts[product] ?? 0) + 1;
    } else {
      selectedProducts[product] = 1;
    }
    update();
    }

  void removeFromCart(CustomerProduct product) {
    if (selectedProducts.containsKey(product)) {
      if (selectedProducts[product]! > 1) {
        selectedProducts[product] = selectedProducts[product]! - 1;
      } else {
        selectedProducts.remove(product);
      }
      update();
    }
  }

  void clearCart() {
    selectedProducts.clear();
    update();
  }

  // Sepet bilgileri
  int getProductCount(CustomerProduct product) {
    return selectedProducts[product] ?? 0;
  }

  int get totalSelectedProducts => selectedProducts.values.fold(0, (sum, count) => sum + count);

  double get totalAmount {
    return selectedProducts.entries.fold(
      0.0,
      (sum, entry) => sum + (entry.key.price * entry.value),
    );
  }

  // Sepete git
  void goToCart() {
    Get.toNamed('/CartPage');
  }
}