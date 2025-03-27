import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(); // Dio instance

  ApiService() {
    // Global ayarları yapalım
    _dio.options.baseUrl = 'https://yourapi.com'; // Base URL
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  // Genel GET isteği
  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception("API GET Error: $e");
    }
  }

  // Genel POST isteği
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("API POST Error: $e");
    }
  }

  // Genel PUT isteği
  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("API PUT Error: $e");
    }
  }

  // Genel DELETE isteği
  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      throw Exception("API DELETE Error: $e");
    }
  }
}
