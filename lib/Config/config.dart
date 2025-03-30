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

  late Customer _currentCustomer;
  late User _currentUser;

  final Map<int, CustomerMenu> _menuMap = {};
  final Map<int, CustomerCategory> _categoryMap = {};
  final Map<int, CustomerProduct> _productMap = {};
  final Map<int, CustomerAccount> _accountMap = {};

  // Getters and setters
  Customer getCurrentCustomer() => _currentCustomer;
  void setCurrentCompany(Customer customer) => _currentCustomer = customer;

  User getCurrentUser() => _currentUser;
  void setCurrentUser(User user) => _currentUser = user;

  void checkSetMenus(List<CustomerMenu> menus){
    for(CustomerMenu menu in menus){
      _menuMap[menu.id] = menu;
    }
  }

  void checkSetCategories(List<CustomerCategory> categories){

    _categoryMap.clear();

    for(CustomerCategory category in categories){
      _categoryMap[category.id] = category;
    }
  }

  void checkSetProducts(List<CustomerProduct> products){

    _productMap.clear();

    for(CustomerProduct product in products){
      _productMap[product.id] = product;
    }
  }

  void checkSetCompanyAccounts(List<CustomerAccount> accounts){

    _accountMap.clear();

    for(CustomerAccount account in accounts){
      _accountMap[account.id] = account;
    }
  }

  List<CustomerMenu> getAllMenus() {
    return _menuMap.values.toList();
  }

  CustomerAccount? getAccountById(int? accountId) {
    return accountId != null ? _accountMap[accountId] : null;
  }

  CustomerAccount? getAccountByCode(int code) {

    for(CustomerAccount account in _accountMap.values){

      if(account.accountCode == code) {
        return account;
      }
    }
    return null;
  }

  CustomerMenu getDefaultMenu() {
    var menus = getAllMenus();
    return menus.firstWhere(
          (menu) => menu.isActive,
      orElse: () => menus[0],
    );
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