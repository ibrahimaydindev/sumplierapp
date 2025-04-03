class TicketOrder {
  final int id;
  int ticketId;
  final int productCode;
  final String productName;
  double quantity;
  double price;
  double totalPrice;
  double discountPrice;
  final int status;
  final bool isChange;
  double newQuantity;
  double? newPrice;
  double? newTotalPrice;
  final int companyCode;
  final String deviceCode;

  TicketOrder({
    required this.id,
    required this.ticketId,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.discountPrice,
    required this.status,
    required this.isChange,
    required this.newQuantity,
    this.newPrice,
    this.newTotalPrice,
    required this.companyCode,
    required this.deviceCode,
  });

  // Factory constructor for creating a TicketOrder instance from JSON
  factory TicketOrder.fromJson(Map<String, dynamic> json) {
    return TicketOrder(
      id: json['id'],
      ticketId: json['ticketId'],
      productCode: json['productCode'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'],
      totalPrice: json['totalPrice'],
      discountPrice: json['discountPrice'],
      status: json['status'],
      isChange: json['isChange'],
      newQuantity: json['newQuantity'],
      newPrice: json['newPrice'],
      newTotalPrice: json['newTotalPrice'],
      companyCode: json['companyCode'],
      deviceCode: json['deviceCode'],
    );
  }

  // Method to convert a TicketOrder instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketId': ticketId,
      'productCode': productCode,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
      'discountPrice': discountPrice,
      'status': status,
      'isChange': isChange,
      'newQuantity': newQuantity,
      'newPrice': newPrice,
      'newTotalPrice': newTotalPrice,
      'companyCode': companyCode,
      'deviceCode': deviceCode,
    };
  }
}