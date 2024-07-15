import '../../../utils/formatters/format_date_and_time.dart';
import '../../admin/models/admin_transfer_model.dart';

class WalletModel {
  final int id;
  final String balance;
  final String currency;
  final String createdAt;
  final String updatedAt;
  final List<Operation> previousRedraws;

  WalletModel({
    required this.id,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.previousRedraws,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      balance: json['balance'],
      currency: json['currency'],
      createdAt: RDateAndTimeFormatter.formatDateObjToNormalDate(
        json['createdAt'],
      ),
      updatedAt: json['updatedAt'],
      // here i check if the previous_redraws is in the response then check if 
      // he isn't empty .
      previousRedraws: json['previous_redraws'] != null
          ? (json['previous_redraws'] as List).isNotEmpty
              ? (json['previous_redraws'] as List)
                  .map(
                    (i) => Operation.fromJson(i),
                  )
                  .toList()
              : []
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'balance': balance,
      'currency': currency,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'previousRedraws': previousRedraws
          .map(
            (operation) => operation.toJson(),
          )
          .toList(),
    };
  }
}

class PaymentReponse {
  final String checkoutId;
  final String paymentUrl;


  PaymentReponse({
    required this.checkoutId,
    required this.paymentUrl,
  });

  factory PaymentReponse.fromJson(Map<String, dynamic> json) {
    return PaymentReponse(
      checkoutId: json['checkoutId'],
      paymentUrl: json['paymentUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkoutId': checkoutId,
      'paymentUrl': paymentUrl,
    };
  }
}