import 'package:sumplier/model/ticker_order.dart';


class Ticket {
  int id;
  int ticketCode;
  int companyCode;
  int resellerCode;
  int userCode;
  String createDateTime;
  String modifiedDateTime;
  double discountTotal;
  double total;
  double taxTotal;
  double generalTotal;
  String? paymentType;
  int paymentStatus;
  String? description;
  int status;
  String deviceCode;
  int accountCode;
  String? accountName;
  List<TicketOrder> ticketOrders;

  Ticket({
    required this.id,
    required this.ticketCode,
    required this.companyCode,
    required this.resellerCode,
    required this.userCode,
    required this.createDateTime,
    required this.modifiedDateTime,
    required this.discountTotal,
    required this.total,
    required this.taxTotal,
    required this.generalTotal,
    this.paymentType,
    required this.paymentStatus,
    this.description,
    required this.status,
    required this.deviceCode,
    required this.accountCode,
    this.accountName,
    required this.ticketOrders,
  });

  // Factory constructor for creating a Ticket instance from JSON
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      ticketCode: json['ticketCode'],
      companyCode: json['companyCode'],
      resellerCode: json['resellerCode'],
      userCode: json['userCode'],
      createDateTime: json['createDateTime'],
      modifiedDateTime: json['modifiedDateTime'],
      discountTotal: json['discountTotal'],
      total: json['total'],
      taxTotal: json['taxTotal'],
      generalTotal: json['generalTotal'],
      paymentType: json['paymentType'],
      paymentStatus: json['paymentStatus'],
      description: json['description'],
      status: json['status'],
      deviceCode: json['deviceCode'],
      accountCode: json['accountCode'],
      accountName: json['accountName'],
      ticketOrders: (json['ticketOrders'] as List)
          .map((order) => TicketOrder.fromJson(order))
          .toList(),
    );
  }

  // Method to convert a Ticket instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketCode': ticketCode,
      'companyCode': companyCode,
      'resellerCode': resellerCode,
      'userCode': userCode,
      'createDateTime': createDateTime,
      'modifiedDateTime': modifiedDateTime,
      'discountTotal': discountTotal,
      'total': total,
      'taxTotal': taxTotal,
      'generalTotal': generalTotal,
      'paymentType': paymentType,
      'paymentStatus': paymentStatus,
      'description': description,
      'status': status,
      'deviceCode': deviceCode,
      'accountCode': accountCode,
      'accountName': accountName,
      'ticketOrders': ticketOrders.map((order) => order.toJson()).toList(),
    };
  }
}