import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumplier/screen/cart_screen/view/cart_page.dart';
import '../controller/order_controller.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});

  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş Ver'),
        actions: [
          // Sepet butonu
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.to(() => CartPage());
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${orderController.totalSelectedProducts}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          // Sol taraf - Kategoriler (1/3)
          Container(
            width: size.width * 0.33,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              children: [
                // Seçili menü başlığı

                // Kategori listesi
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: orderController.categories.length,
                      itemBuilder: (context, index) {
                        final category = orderController.categories[index];
                        final isSelected =
                            orderController
                                .selectedCategory
                                .value
                                ?.categoryCode ==
                            category.categoryCode;

                        return GestureDetector(
                          onTap: () {
                            orderController.onCategorySelected(category);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.blue.withOpacity(0.15)
                                      : Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow:
                                  isSelected
                                      ? [
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.1),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ]
                                      : null,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: ListTile(
                              selected: isSelected,
                              title: Text(
                                category.categoryName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  color:
                                      isSelected ? Colors.blue : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sağ taraf - Ürünler (2/3)
          Expanded(
            child: Column(
              children: [
                // Seçili kategori başlığı

                // Ürün grid'i
                Expanded(
                  child: Obx(
                    () => GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: orderController.products.length,
                      itemBuilder: (context, index) {
                        final product = orderController.products[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: GestureDetector(
                            onTap: () => orderController.addToCart(product),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Ürün resmi
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      image: DecorationImage(
                                        image: product.image != null &&
                                                product.image!.isNotEmpty
                                            ? NetworkImage(product.image!)
                                            : AssetImage(
                                                    'assets/app_logo.png',
                                                  )
                                                as ImageProvider, // Yedek resim
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Using Image.network for better control
                                    child: Image.network(
                                      product.image ?? '',
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                      (loadingProgress.expectedTotalBytes ?? 1)
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(child: Icon(Icons.error)); // Error icon
                                      },
                                    ),
                                  ),
                                ),
                                // Ürün adı
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(12),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        product.productName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
