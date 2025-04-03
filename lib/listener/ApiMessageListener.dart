class ApiMessageListener {
  final void Function() onSuccess;
  final void Function(String error) onFail;

  ApiMessageListener({required this.onSuccess, required this.onFail});
}