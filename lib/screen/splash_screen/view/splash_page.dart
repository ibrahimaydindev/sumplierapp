import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo veya uygulama adı
            Text(
              "Sumplier",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            
            // Progress Bar
            Obx(() => SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: splashController.progress.value,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 10,
              ),
            )),
            
            SizedBox(height: 20),
            
            // Yüzde göstergesi
            Obx(() => Text(
              "${(splashController.progress.value * 100).toInt()}%",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )),
            
            SizedBox(height: 20),
            
            // Yüklenen veri bilgisi
            Obx(() => Text(
              splashController.currentLoadingText.value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }
}
