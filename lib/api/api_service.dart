import 'package:dio/dio.dart';
import 'package:sumplier/model/company.dart';
import '../model/api_result.dart';

class ApiService {
  final Dio _dio = Dio(); // Dio instance

  ApiService() {
    // Base URL'i güncelliyoruz
    _dio.options.baseUrl = 'https://api.sumplier.com/SumplierAPI';
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

  // getCompanyLogin
  Future<ApiResult<Company>> getCompanyLogin(String email, String password) async {
    try {
      final response = await _dio.post('/GetCompanyLogin', 
        data: {
          'email': email,
          'password': password
        }
      );
      
      if (response.statusCode == 200) {
        final company = Company.fromJson(response.data);
        return ApiResult.success(company);
      } else {
        return ApiResult.failure('Şirket girişi başarısız');
      }
    } catch (e) {
      return ApiResult.failure("Şirket girişi hatası: $e");
    }
  }

  // Foe example if it would be list
  Future<ApiResult<List<Company>>> getCompanyList() async {
    try {
      final response = await _dio.get('/GetCompanies');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final companies = jsonList.map((json) => Company.fromJson(json)).toList();
        return ApiResult.success(companies);
      } else {
        return ApiResult.failure('Şirket listesi alınamadı');
      }
    } catch (e) {
      return ApiResult.failure("Şirket listesi hatası: $e");
    }
  }
}
