import 'package:dio/dio.dart' as dio; // Alias Dio
import 'package:get/get.dart'; // GetX library (no need to alias here)
import '../listener/ApiObjectListener.dart';
import '../listener/ApiListListener.dart';
import '../model/category.dart';
import '../model/company_account.dart';
import '../model/menu.dart';
import '../model/product.dart';
import '../model/company.dart';
import '../model/user_model.dart';

class ApiService extends GetxService {
  final dio.Dio _dio = dio.Dio(); // Dio instance with alias

  ApiService() {
    // Base URL'i güncelliyoruz
    _dio.options.baseUrl = 'https://api.sumplier.com/SumplierAPI';

    // Timeout yapılandırmaları
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  // Şirket listesi almak için GET isteği (Eski API yoluyla)
  Future<void> getCompanyList({
    required ApiListListener<Company> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get('/GetCompanies');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final companies =
        jsonList.map((json) => Company.fromJson(json)).toList();
        listener.onSuccess(companies); // Başarıyla listeyi geri döndür
      } else {
        listener.onFail('Şirket listesi alınamadı');
      }
    } catch (e) {
      listener.onFail("Şirket listesi hatası: $e");
    }
  }

  // Şirket girişi yapmak için GET isteği (Eski API yoluyla)
  Future<void> getCompanyLogin({
    required String email,
    required String password,
    required ApiObjectListener<Company> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/Company/GetCompanyLogin',
        queryParameters: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        listener.onSuccess(Company.fromJson(response.data)); // Company döndür
      } else {
        listener.onFail("Şirket girişi hatası: null");
      }
    } catch (e) {
      listener.onFail("Şirket girişi hatası: $e");
    }
  }

  // Kullanıcı girişi yapmak için GET isteği (Eski API yoluyla)
  Future<void> getUserLogin({
    required String email,
    required String password,
    required ApiObjectListener<User> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/Users/GetUserLogin',
        queryParameters: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        listener.onSuccess(User.fromJson(response.data)); // User döndür
      } else {
        listener.onFail("Kullanıcı girişi hatası: null");
      }
    } catch (e) {
      listener.onFail("Kullanıcı girişi hatası: $e");
    }
  }

  // Menüleri çeken fonksiyon (Yeni listener'lar ile)
  Future<void> fetchMenus({
    required int companyCode,
    required int resellerCode,
    required ApiListListener<Menu> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/Menu/GetMenu',
        queryParameters: {
          'companyCode': companyCode,
          'resellerCode': resellerCode,
        },
      );

      if (response.statusCode == 200) {
        List<Menu> menus = (response.data as List)
            .map((menu) => Menu.fromJson(menu))
            .toList();
        if (menus.isNotEmpty) {
          listener.onSuccess(menus);
        } else {
          listener.onFail("Menüler bulunamadı.");
        }
      } else {
        listener.onFail("Menüler alınamadı: ${response.statusCode}");
      }
    } catch (e) {
      listener.onFail(e.toString());
    }
  }

  // Kategorileri çeken fonksiyon (Yeni listener'lar ile)
  Future<void> fetchCategories({
    required int companyCode,
    required int resellerCode,
    required ApiListListener<Category> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/CustomerCategory/GetCategory',
        queryParameters: {
          'companyCode': companyCode,
          'resellerCode': resellerCode,
        },
      );

      if (response.statusCode == 200) {
        List<Category> categories = (response.data as List)
            .map((category) => Category.fromJson(category))
            .toList();
        if (categories.isNotEmpty) {
          listener.onSuccess(categories);
        } else {
          listener.onFail("Kategoriler bulunamadı.");
        }
      } else {
        listener.onFail("Kategoriler alınamadı: ${response.statusCode}");
      }
    } catch (e) {
      listener.onFail(e.toString());
    }
  }

  // Ürünleri çeken fonksiyon (Yeni listener'lar ile)
  Future<void> fetchProducts({
    required int companyCode,
    required int resellerCode,
    required ApiListListener<Product> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/Product/GetProductAll',
        queryParameters: {'companyCode': companyCode, 'resellerCode': resellerCode,},
      );

      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        if (products.isNotEmpty) {
          listener.onSuccess(products);
        } else {
          listener.onFail("Ürünler bulunamadı.");
        }
      } else {
        listener.onFail("Ürünler alınamadı: ${response.statusCode}");
      }
    } catch (e) {
      listener.onFail(e.toString());
    }
  }

  // Şirket hesaplarını çeken fonksiyon (Yeni listener'lar ile)
  Future<void> fetchCompanyAccounts({
    required int companyCode,
    required int resellerCode,
    required ApiObjectListener<CompanyAccount> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/CompanyAccount/GetCompanyAccountAll',
        queryParameters: {
          'companyCode': companyCode,
          'resellerCode': resellerCode,
        },
      );

      if (response.statusCode == 200) {
        CompanyAccount companyAccount = CompanyAccount.fromJson(response.data);
        listener.onSuccess(companyAccount);
      } else {
        listener.onFail("Hesap alınamadı: ${response.statusCode}");
      }
    } catch (e) {
      listener.onFail(e.toString());
    }
  }
}
