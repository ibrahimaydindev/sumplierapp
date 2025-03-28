enum InfoMessage {
  generalError(0, "Hata"),
  aError(1,"Bir hata oluştu !"),
  emailError(0, "Email alanı boş bırakılamaz."),
  passwordError(1, "Şifre alanı boş bırakılamaz.");


  final int code;
  final String message;

  const InfoMessage(this.code, this.message);
}