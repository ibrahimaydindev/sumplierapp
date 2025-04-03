import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final cartController = Get.put(CartController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sepetim'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('Sepeti Temizle'),
                  content: Text('Sepetinizdeki tüm ürünler silinecek. Emin misiniz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('İptal'),
                    ),
                    TextButton(
                      onPressed: () {
                        cartController.clearCart();
                        Get.back();
                      },
                      child: Text('Temizle', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.selectedProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Sepetiniz boş',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text('Alışverişe Başla'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Ürün listesi
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: cartController.selectedProducts.length,
                itemBuilder: (context, index) {
                  final product = cartController.selectedProducts.keys.elementAt(index);
                  final quantity = cartController.selectedProducts[product]!;
                  
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(product.image ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${product.price.toStringAsFixed(2)} TL',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () => cartController.decreaseQuantity(product),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () => cartController.increaseQuantity(product),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Toplam tutar ve sipariş butonu
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Toplam Ürün: ${cartController.totalItems}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Toplam Tutar: ${cartController.totalAmount.toStringAsFixed(2)} TL',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Siparişi Tamamla'),
                            content: Text('Siparişinizi tamamlamak istediğinize emin misiniz?'),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text('İptal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  cartController.completeOrder();
                                  Get.back();
                                },
                                child: Text('Tamamla'),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Siparişi Tamamla',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
