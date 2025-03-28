import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Örnek sepet verileri
  List<Map<String, dynamic>> cartItems = [
    {"name": "Ürün 1", "price": 50, "quantity": 1},
    {"name": "Ürün 2", "price": 30, "quantity": 2},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
    {"name": "Ürün 3", "price": 20, "quantity": 1},
  ];

  // Toplam tutarı hesaplama
  double getTotalPrice() {
    return cartItems.fold(
      0,
      (total, item) => total + (item["price"] * item["quantity"]),
    );
  }

  // Sepetteki toplam ürün sayısını hesaplama
  int getTotalItems() {
    return cartItems.fold(0, (total, item) => total + item["quantity"] as int);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Geri butonu
          },
        ),
        title: const Text(
          "Sepet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              // Tüm sepeti silme işlemi
              setState(() {
                cartItems.clear();
              });
            },
          ),
        ],
      ),
      body:
          cartItems.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/images/empty_basket.png", // Boş sepet resmi
                      height: size.height * 0.2,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Sipariş listeniz boş",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  // Sepet Ürünleri
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                // Ürün Bilgileri
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["name"],
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        "₺${item["price"]}",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Ürün Miktarını Artır/Azalt
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          if (item["quantity"] > 1) {
                                            item["quantity"]--;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      "${item["quantity"]}",
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          item["quantity"]++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                // Ürünü Sil
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      cartItems.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Toplam Tutar ve Siparişi Gönder Butonu
                  // Toplam Tutar ve Siparişi Gönder Butonu
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.9, // Genişlik ekranın %90'ı kadar
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 40.0,
                        ), // En alttan biraz yukarıda
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white, // Arka plan beyaz
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26, // Hafif gölge
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Toplam Tutar ve Ürün Sayısı
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Toplam Ürün: ${getTotalItems()}",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  "Toplam Tutar: ₺${getTotalPrice().toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            // Siparişi Gönder Butonu
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      content: const Text(
                                        "Siparişiniz başarıyla gönderildi!",
                                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: const Duration(
                                        seconds: 1,
                                      ), // Snackbar'ın görünme süresi
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                child: const Text(
                                  "Siparişi Gönder",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
