class ApiObjectListener<T> {
  final void Function(T data) onSuccess;
  final void Function(String error) onFail;

  ApiObjectListener({required this.onSuccess, required this.onFail});
}