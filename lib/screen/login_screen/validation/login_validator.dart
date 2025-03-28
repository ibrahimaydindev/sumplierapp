class LoginValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email alanı boş bırakılamaz';
    }
    if (!email.contains('@')) {
      return 'Geçersiz email formatı';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    }
    if (password.length < 8) {
      return 'Şifre en az 8 karakter olmalı';
    }
    return null;
  }
}
