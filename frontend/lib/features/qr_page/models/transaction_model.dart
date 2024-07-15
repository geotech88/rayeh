import 'dart:convert';

import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';
import '../../success_page/models/invoice_model.dart';

Transaction transactionFromJson(String str) => Transaction.fromJson(
      jsonDecode(str)['data'],
    );

class Transaction {
  final int id;
  final String name;
  final int status;
  final User? sender;
  final User? receiver;
  final InvoiceModel? invoice;
  final Trip? trip;

  Transaction({
    required this.id,
    required this.name,
    required this.status,
    required this.sender,
    required this.receiver,
    required this.invoice,
    required this.trip,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      receiver:
          json['receiver'] != null ? User.fromJson(json['receiver']) : null,
      invoice: json['invoice'] != null
          ? InvoiceModel.fromJson(json['invoice'])
          : null,
      trip: json['trip'] != null ? Trip.fromJson(json['trip']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'sender': sender!.toJson(),
      'receiver': receiver!.toJson(),
      'trip': trip!.toJson(),
    };
  }
}
