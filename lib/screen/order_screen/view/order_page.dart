import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop(); // Geri butonu
          },
        ),
        title: Image.asset(
          "lib/assets/images/app_logo.png", // Ortadaki logo
          height: size.height * 0.2,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Colors.white,), // Sağdaki sepet ikonu
            onPressed: () {
              // Sepet işlemleri
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Row(
        children: [
          // Sol kısım: Menüler
          Container(
            width: size.width * 0.3, // Ekranın 3'te 1'i
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: 10, // Menü sayısı
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Menü ${index + 1}"),
                  onTap: () {
                    // Menü seçimi işlemleri
                  },
                );
              },
            ),
          ),
          // Sağ kısım: Ürünler
          Expanded(
            child: Container(
              color: Colors.white,
              child: GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 600 ? 3 : 2, // Responsive sütun sayısı
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 3 / 4, // Ürün kartlarının oranı
                ),
                itemCount: 20, // Ürün sayısı
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: size.width * 0.1,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Ürün ${index + 1}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "₺${(index + 1) * 10}",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}