import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          if (splashController.isLoading.value) {
            return CircularProgressIndicator();
          } else {
            return Text("Yükleme tamamlandı!");
          }
        }),
      ),
    );
  }
}
