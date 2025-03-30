import 'package:dio/dio.dart' as dio; // Alias Dio
import 'package:get/get.dart'; // GetX library (no need to alias here)
import 'package:sumplier/model/customer.dart';
import '../listener/ApiObjectListener.dart';
import '../listener/ApiListListener.dart';
import '../model/customer_category.dart';
import '../model/customer_account.dart';
import '../model/customer_menu.dart';
import '../model/customer_product.dart';
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


  // Şirket girişi yapmak için GET isteği (Eski API yoluyla)
  Future<void> getCustomerLogin({
    required String email,
    required String password,
    required ApiObjectListener<Customer> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/Customer/GetCustomerLogin',
        queryParameters: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        listener.onSuccess(Customer.fromJson(response.data)); // Customer döndür
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
        listener.onSuccess(User.fromJson(response.data)); // return User
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
    required int customerCode,
    required ApiListListener<CustomerMenu> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/CustomerMenu/GetMenu',
        queryParameters: {
          'companyCode': companyCode,
          'resellerCode': resellerCode,
          'customerCode': customerCode,
        },
      );

      if (response.statusCode == 200) {
        List<CustomerMenu> menus = (response.data as List)
            .map((menu) => CustomerMenu.fromJson(menu))
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
    required int customerCode,
    required ApiListListener<CustomerCategory> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/CustomerCategory/GetCategory',
        queryParameters: {
          'companyCode': companyCode,
          'resellerCode': resellerCode,
          'customerCode': customerCode,
        },
      );

      if (response.statusCode == 200) {
        List<CustomerCategory> categories = (response.data as List)
            .map((category) => CustomerCategory.fromJson(category))
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
    required int customerCode,
    required ApiListListener<CustomerProduct> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/CustomerProduct/GetProductAll',
        queryParameters: {
          'companyCode': companyCode,
          'resellerCode': resellerCode,
          'customerCode': customerCode,
        },
      );

      if (response.statusCode == 200) {
        List<CustomerProduct> products = (response.data as List)
            .map((product) => CustomerProduct.fromJson(product))
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

  Future<void> fetchCompanyAccounts({
    required int companyCode,
    required int resellerCode,
    required int customerCode,
    required ApiListListener<CustomerAccount> listener,
  }) async {
    try {
      final dio.Response response = await _dio.get(
        '/CustomerAccount/GetCustomerAccountAll',
        queryParameters: {
          'companyCode': companyCode,
          'resellerCode': resellerCode,
          'customerCode': customerCode,
        },
      );

      if (response.statusCode == 200) {
        List<CustomerAccount> accounts = (response.data as List)
            .map((json) => CustomerAccount.fromJson(json))
            .toList();
        if (accounts.isNotEmpty) {
          listener.onSuccess(accounts);
        } else {
          listener.onFail("Şirket hesapları bulunamadı.");
        }
      } else {
        listener.onFail("Hesaplar alınamadı: ${response.statusCode}");
      }
    } catch (e) {
      listener.onFail("Hesaplar alınırken hata oluştu: $e");
    }
  }

  // Menü listesi almak için GET isteği
  Future<List<CustomerMenu>> getMenuList() async {
    try {
      final dio.Response response = await _dio.get('/GetMenus');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final menus = jsonList.map((json) => CustomerMenu.fromJson(json)).toList();
        return menus;
      } else {
        throw Exception('Menü listesi alınamadı');
      }
    } catch (e) {
      throw Exception("Menü listesi hatası: $e");
    }
  }

  // Kategori listesi almak için GET isteği
  Future<List<CustomerCategory>> getCategoryList() async {
    try {
      final dio.Response response = await _dio.get('/GetCategories');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final categories = jsonList.map((json) => CustomerCategory.fromJson(json)).toList();
        return categories;
      } else {
        throw Exception('Kategori listesi alınamadı');
      }
    } catch (e) {
      throw Exception("Kategori listesi hatası: $e");
    }
  }

  // Ürün listesi almak için GET isteği
  Future<List<CustomerProduct>> getProductList() async {
    try {
      final dio.Response response = await _dio.get('/GetProducts');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final products = jsonList.map((json) => CustomerProduct.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Ürün listesi alınamadı');
      }
    } catch (e) {
      throw Exception("Ürün listesi hatası: $e");
    }
  }
}
