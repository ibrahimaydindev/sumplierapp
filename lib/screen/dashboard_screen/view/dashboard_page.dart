import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sumplier/screen/dashboard_screen/controller/dashboard_controller.dart';
import 'package:sumplier/screen/order_screen/view/order_page.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});
  
  final dashboardController = Get.put(DashboardController());

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // Sayfa başlıkları ve ikonları
  final List<String> _titles = [
    "Sipariş Oluştur",
    "Raporlar",
    "Ayarlar",
    "Destek",
  ];

  final List<IconData> _icons = [
    Icons.add_shopping_cart,
    Icons.bar_chart,
    Icons.settings,
    Icons.support_agent,
  ];


  void _onItemTapped(int index) {
    if (index == 2) {
      // Çıkış Yap butonuna basıldığında Bottom Sheet aç
      _showLogoutConfirmation();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showLogoutConfirmation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Bottom Sheet'in yüksekliğini kontrol etmek için
      backgroundColor: Colors.transparent, // Arka planı şeffaf yap
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.2, // Genişlik ekranın %90'ı kadar
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Üstteki çizgi
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Çıkmak istediğinize emin misiniz?",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Çıkış işlemi
                                Navigator.of(
                                  context,
                                ).pop(); // Bottom Sheet'i kapat
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12.0,
                                ),
                              ),
                              child: Text(
                                "Evet",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12.0,
                                ),
                                backgroundColor: Colors.grey,
                              ),
                              child: Text(
                                "Hayır",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "lib/assets/images/app_logo.png",
          width: size.width * 0.4,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Menü açma işlemleri
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size.width > 600 ? 3 : 2,
              crossAxisSpacing: size.width * 0.04,
              mainAxisSpacing: size.height * 0.03,
            ),
            itemCount: _titles.length,
            itemBuilder: (context, index) {
              return _buildDashboardCard(
                context,
                title: _titles[index],
                icon: _icons[index],
                onTap: () {
                  switch (_titles[index]) {
                    case "Sipariş Oluştur":
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => OrderPage()),
                      );
                      break;
                  }
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Anasayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Çıkış Yap"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: size.width * 0.15, color: Colors.blue),
              SizedBox(height: size.height * 0.02),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
