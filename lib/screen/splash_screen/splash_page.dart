import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller'ı bağla
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white, // Beyaz arka plan
      body: Center(
        child: CircularProgressIndicator(), // Ortada dönen progress
      ),
    );
  }
}
