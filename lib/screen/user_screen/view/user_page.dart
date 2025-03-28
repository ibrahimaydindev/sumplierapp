import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumplier/screen/dashboard_screen/view/dashboard_page.dart';
import 'package:sumplier/screen/user_screen/controller/user_controller.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserController userController = Get.put(UserController());
  bool rememberMe = false;
  bool isPasswordHidden = true; // Şifre gizleme durumu

  @override
  void initState() {
    super.initState();
    userController.loadSavedCredentials();
  }

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
                  "User",
                  style: TextStyle(
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              TextField(
                controller: userController.emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                controller: userController.passwordController,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden; // Şifre görünürlüğünü değiştir
                      });
                    },
                  ),
                ),
                obscureText: isPasswordHidden, // Şifre gizleme durumu
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text("Beni Hatırla"),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  // Butonun loading durumunu kontrol et
                  return ElevatedButton(
                    onPressed: userController.isLoading.value
                        ? null // Eğer loading durumundaysa buton devre dışı
                        : () async {
                            final email = userController.emailController.text.trim();
                            final password = userController.passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              Get.snackbar(
                                "Hata",
                                "Email ve şifre alanları boş bırakılamaz.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                              return;
                            }

                            try {
                              // Loading durumunu başlat
                              userController.isLoading.value = true;

                              // Kullanıcı giriş işlemi
                              await userController.getUserLogin(email, password); // Burada dönüş değeri alınmaz


                              if (userController.user.value != null) {
                                Get.snackbar(
                                  "Başarılı",
                                  "Giriş başarılı!",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                                Get.to(() => DashboardPage());
                              } else {
                                Get.snackbar(
                                  "Hata",
                                  "Giriş başarısız. Lütfen bilgilerinizi kontrol edin.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            } catch (e) {
                              Get.snackbar(
                                "Hata",
                                "Bir hata oluştu: ${e.toString()}",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                            } finally {
                              // Loading durumunu durdur
                              userController.isLoading.value = false;
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: userController.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Giriş Yap",
                            style: TextStyle(fontSize: 18),
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