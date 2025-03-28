import 'package:dio/dio.dart' as dio; // Alias Dio
import 'package:get/get.dart'; // GetX library (no need to alias here)
import 'package:sumplier/model/company.dart';
import 'package:sumplier/model/user_model.dart';

class ApiService extends GetxService {
  final dio.Dio _dio = dio.Dio(); // Dio instance with alias

  ApiService() {
    // Base URL'i güncelliyoruz
    _dio.options.baseUrl = 'https://api.sumplier.com/SumplierAPI';

    // Timeout yapılandırmaları
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  // Genel GET isteği
  Future<dio.Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception("API GET Error: $e");
    }
  }

  // Genel POST isteği
  Future<dio.Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("API POST Error: $e");
    }
  }

  // Genel PUT isteği
  Future<dio.Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("API PUT Error: $e");
    }
  }

  // Genel DELETE isteği
  Future<dio.Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      throw Exception("API DELETE Error: $e");
    }
  }

  // Şirket listesi almak için GET isteği
  Future<List<Company>> getCompanyList() async {
    try {
      final dio.Response response = await _dio.get('/GetCompanies');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final companies =
            jsonList.map((json) => Company.fromJson(json)).toList();
        return companies; // List<Company> döndürüyoruz
      } else {
        throw Exception('Şirket listesi alınamadı');
      }
    } catch (e) {
      throw Exception("Şirket listesi hatası: $e");
    }
  }

  // Şirket girişi yapmak için GET isteği
  Future<Company?> getCompanyLogin(String email, String password) async {
    try {
      final dio.Response response = await _dio.get(
        '/Company/GetCompanyLogin',
        queryParameters: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return Company.fromJson(response.data); // Company modelini döndürüyoruz
      } else {
        throw Exception("api Şirket girişi hatası: null");
      }
    } catch (e) {
      throw Exception("api Şirket girişi hatası: $e");
    }
  }

  Future<User?> getUserLogin(String email, String password) async {
    try {
      final dio.Response response = await _dio.get(
        '/Users/GetUserLogin',
        queryParameters: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data); // User modelini döndürüyoruz
      } else {
        throw Exception("api Kullanıcı girişi hatası: null");
      }
    } catch (e) {
      throw Exception("api Kullanıcı girişi hatası: $e");
    }
  }
}
