import 'dart:collection';

import 'package:sumplier/model/category.dart';
import 'package:sumplier/model/company_account.dart';
import 'package:sumplier/model/menu.dart';
import 'package:sumplier/model/product.dart';

import '../model/company.dart';
import '../model/user_model.dart';

class Config {
  static final Config _instance = Config._internal();
  Config._internal();

  static Config get instance => _instance;

  late Company _currentCompany;
  late User _currentUser;

  final Map<int, Menu> _menuMap = {};
  final Map<int, Category> _categoryMap = {};
  final Map<int, Product> _productMap = {};
  final Map<int, CompanyAccount> _accountMap = {};

  // Getters and setters
  Company getCurrentCompany() => _currentCompany;
  void setCurrentCompany(Company company) => _currentCompany = company;

  User getCurrentUser() => _currentUser;
  void setCurrentUser(User user) => _currentUser = user;

  void checkSetMenus(List<Menu> menus){
    for(Menu menu in menus){
      _menuMap[menu.id] = menu;
    }
  }

  void checkSetCategories(List<Category> categories){

    _categoryMap.clear();

    for(Category category in categories){
      _categoryMap[category.id] = category;
    }
  }

  void checkSetProducts(List<Product> products){

    _productMap.clear();

    for(Product product in products){
      _productMap[product.id] = product;
    }
  }

  void checkSetCompanyAccounts(List<CompanyAccount> accounts){

    _accountMap.clear();

    for(CompanyAccount account in accounts){
      _accountMap[account.id] = account;
    }
  }

  List<Menu> getAllMenus() {
    return _menuMap.values.toList();
  }

  CompanyAccount? getAccountById(int? accountId) {
    return accountId != null ? _accountMap[accountId] : null;
  }

  CompanyAccount? getAccountByCode(int code) {

    for(CompanyAccount account in _accountMap.values){

      if(account.accountCode == code) {
        return account;
      }
    }
    return null;
  }

  Menu getDefaultMenu() {
    var menus = getAllMenus();
    return menus.firstWhere(
          (menu) => menu.isActive,
      orElse: () => menus[0],
    );
  }


  List<Category> getMenuCategory(Menu menu) {
    List<Category> categories = [];

    int menuCode = menu.menuCode;

    _categoryMap.forEach((key, category) {
      if (category.menuCode == menuCode) {
        categories.add(category);
      }
    });

    return categories;
  }

  List<Product> getCategoryProducts(Category category) {
    return _productMap.values
        .where((product) => product.categoryCode == category.categoryCode)
        .toList();
  }
}