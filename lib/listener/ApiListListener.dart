class ApiListListener<T> {
  final void Function(List<T> data) onSuccess;
  final void Function(String error) onFail;

  ApiListListener({required this.onSuccess, required this.onFail});
}