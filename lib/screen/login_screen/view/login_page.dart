import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumplier/database/pref_helper.dart';
import 'package:sumplier/enum/config_key.dart';
import 'package:sumplier/enum/info_message.dart';
import 'package:sumplier/screen/user_screen/view/user_page.dart';

import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginController = Get.put(LoginController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isPasswordHidden = true.obs; // Şifre gizleme durumu

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sumplier",
                  style: TextStyle(
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Şirket Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: size.height * 0.02),
              Obx(() {
                return TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        isPasswordHidden.value = !isPasswordHidden.value; // Şifre görünürlüğünü değiştir
                      },
                    ),
                  ),
                  obscureText: isPasswordHidden.value, // Şifre gizleme durumu
                );
              }),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  // Butonun loading durumunu kontrol et
                  return ElevatedButton(
                    onPressed: loginController.isLoading.value
                        ? null // Eğer loading durumundaysa buton devre dışı
                        : () async {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              Get.snackbar(
                                "Hata",
                                "Email ve şifre alanları boş bırakılamaz.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }

                            try {
                              // Loading durumunu başlat
                              loginController.isLoading.value = true;

                              // Login işlemini başlat
                              await loginController.getCompanyLogin(
                                  email, password);

                              if (loginController.company.value != null) {
                                if (PrefHelper.containsKey(
                                    ConfigKey.company.name)) {
                                  PrefHelper.remove(ConfigKey.company.name);
                                }

                                // Kullanıcı sayfasına yönlendir
                                Get.to(() => UserPage());
                                Get.snackbar(
                                  "Başarılı",
                                  "Giriş başarılı.",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else {
                                Get.snackbar(
                                  InfoMessage.generalError.message,
                                  "Giriş başarısız. Lütfen bilgilerinizi kontrol edin.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            } catch (e) {
                              Get.snackbar(
                                InfoMessage.generalError.message,
                                "Bir hata oluştu: ${e.toString()}",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                            } finally {
                              // Loading durumunu durdur
                              loginController.isLoading.value = false;
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: loginController.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Giriş Yap",
                            style: TextStyle(fontSize: size.width * 0.05),
                          ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}