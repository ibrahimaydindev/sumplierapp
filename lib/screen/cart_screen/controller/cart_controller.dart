import 'package:get/get.dart';
import '../../order_screen/controller/order_controller.dart';
import 'package:sumplier/model/customer_product.dart';

class CartController extends GetxController {
  late final OrderController orderController;
  
  @override
  void onInit() {
    super.onInit();
    // OrderController'ı bul veya oluştur
    orderController = Get.find<OrderController>();
  }
  
  // Sepetteki ürünleri getir
  Map<CustomerProduct, int> get selectedProducts => orderController.selectedProducts;
  
  // Toplam ürün sayısı
  int get totalItems => orderController.totalSelectedProducts;
  
  // Toplam tutar
  double get totalAmount => orderController.totalAmount;
  
  // Ürün miktarını artır
  void increaseQuantity(CustomerProduct product) {
    orderController.addToCart(product);
  }
  
  // Ürün miktarını azalt
  void decreaseQuantity(CustomerProduct product) {
    orderController.removeFromCart(product);
  }
  
  // Sepeti temizle
  void clearCart() {
    orderController.clearCart();
  }
  
  // Siparişi tamamla
  void completeOrder() {
    clearCart();
    Get.back();
  }
}