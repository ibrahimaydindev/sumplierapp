import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, // Ekran genişliğine göre padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo or Title
              Center(
                child: Text(
                  "Sumplier",
                  style: TextStyle(
                    fontSize: size.width * 0.07, // Ekran genişliğine göre font boyutu
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05), // Ekran yüksekliğine göre boşluk

              // Email TextField
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: size.height * 0.02),

              // Password TextField
              TextField(
                decoration: InputDecoration(
                  labelText: "Şifre",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                ),
                obscureText: true,
              ),
              SizedBox(height: size.height * 0.01),

              // Forgot Password Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password logic
                  },
                  child: Text(
                    "Şifremi Unuttum?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Login logic
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(fontSize: size.width * 0.05),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}