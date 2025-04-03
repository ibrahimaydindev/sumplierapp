enum ApiEndpoint {
  baseUrl('https://api.sumplier.com/SumplierAPI'),
  customerLogin('/Customer/GetCustomerLogin'),
  userLogin('/Users/GetUserLogin'),
  fetchMenus('/CustomerMenu/GetMenu'),
  fetchCategories('/CustomerCategory/GetCategory'),
  fetchProducts('/CustomerProduct/GetProductAll'),
  fetchCompanyAccounts('/CustomerAccount/GetCustomerAccountAll');

  final String endpoint;

  const ApiEndpoint(this.endpoint);
}
