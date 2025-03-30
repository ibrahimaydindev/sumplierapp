import 'package:sumplier/model/customer_category.dart';
import 'package:sumplier/model/customer_account.dart';
import 'package:sumplier/model/customer.dart';
import 'package:sumplier/model/customer_menu.dart';
import 'package:sumplier/model/customer_product.dart';
import '../model/user_model.dart';

class Config {
  static final Config _instance = Config._internal();
  Config._internal();

  static Config get instance => _instance;

  Customer? _currentCustomer;
  User? _currentUser;
  List<CustomerMenu> _menus = [];
  List<CustomerCategory> _categories = [];
  List<CustomerProduct> _products = [];
  List<CustomerAccount> _companyAccounts = [];

  final Map<int, CustomerMenu> _menuMap = {};
  final Map<int, CustomerCategory> _categoryMap = {};
  final Map<int, CustomerProduct> _productMap = {};
  final Map<int, CustomerAccount> _accountMap = {};

  // Getters and setters
  Customer getCurrentCustomer() => _currentCustomer!;
  User getCurrentUser() => _currentUser!;
  List<CustomerMenu> getMenus() => _menus;
  List<CustomerCategory> getCategories() => _categories;
  List<CustomerProduct> getProducts() => _products;
  List<CustomerAccount> getCompanyAccounts() => _companyAccounts;

  void setCurrentCompany(Customer customer) {
    _currentCustomer = customer;
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  void checkSetMenus(List<CustomerMenu> menus) {
    _menus = menus;
  }

  void checkSetCategories(List<CustomerCategory> categories) {
    _categories = categories;
  }

  void checkSetProducts(List<CustomerProduct> products) {
    _products = products;
  }

  void checkSetCompanyAccounts(List<CustomerAccount> accounts) {
    _companyAccounts = accounts;
  }

  List<CustomerMenu> getAllMenus() {
    return _menuMap.values.toList();
  }

  CustomerAccount? getAccountById(int? accountId) {
    return accountId != null ? _accountMap[accountId] : null;
  }

  CustomerAccount? getAccountByCode(int code) {
    for (CustomerAccount account in _accountMap.values) {
      if (account.accountCode == code) {
        return account;
      }
    }
    return null;
  }

  CustomerMenu getDefaultMenu() {
    var menus = getAllMenus();
    return menus.firstWhere((menu) => menu.isActive, orElse: () => menus[0]);
  }

  List<CustomerCategory> getMenuCategory(CustomerMenu menu) {
    List<CustomerCategory> categories = [];

    int menuCode = menu.menuCode;

    _categoryMap.forEach((key, category) {
      if (category.menuCode == menuCode) {
        categories.add(category);
      }
    });

    return categories;
  }

  List<CustomerProduct> getCategoryProducts(CustomerCategory category) {
    return _productMap.values
        .where((product) => product.categoryCode == category.categoryCode)
        .toList();
  }
}
