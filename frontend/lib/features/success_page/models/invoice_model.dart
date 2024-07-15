import '../../authentication/models/user_model.dart';

class InvoiceModel {
  final int? id;
  final double amount;
  final String paymentMethod;
  final String currency;
  final String status;
  final String issueDate;
  final String dueDate;
  final User? user;
  // Default constructor
  InvoiceModel.empty()
      : id = null,
        amount = 0.0,
        paymentMethod = '',
        currency = '',
        status = '',
        issueDate = '',
        dueDate = '',
        user = null;
  
  InvoiceModel({
    this.id,
    required this.amount,
    required this.paymentMethod,
    required this.currency,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    this.user,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      amount: json['amount'],
      paymentMethod: json['paymentMethod'],
      currency: json['currency'],
      status: json['status'],
      issueDate: json['issueDate'],
      dueDate: json['dueDate'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'currency': currency,
      'status': status,
      'issueDate': issueDate,
      'dueDate': dueDate,
      'user': user!.toJson(),
    };
  }
}
