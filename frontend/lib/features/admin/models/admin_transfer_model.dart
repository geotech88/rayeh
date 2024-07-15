import '../../authentication/models/user_model.dart';

class TransferRequestInfos {
  final String message;
  final TransfersData data;

  TransferRequestInfos({required this.message, required this.data});

  factory TransferRequestInfos.fromJson(Map<String, dynamic> json) {
    return TransferRequestInfos(
      message: json['message'],
      data: TransfersData.fromJson(json['data']),
    );
  }
}

class TransfersData {
  final List<Operation> pendingOperations;
  final List<Operation> previousOperations;

  TransfersData({required this.pendingOperations, required this.previousOperations});

  factory TransfersData.fromJson(Map<String, dynamic> json) {
    return TransfersData(
      pendingOperations: (json['pendingOperations'] as List).map((i) => Operation.fromJson(i)).toList(),
      previousOperations: (json['previousOperations'] as List).map((i) => Operation.fromJson(i)).toList(),
    );
  }
}

class Operation {
  final int id;
  final double amount;
  final String accountNumber;
  final bool pending;
  final String? status;
  final String createdAt;
  final String updatedAt;
  final User user;

  Operation({required this.id, required this.amount, required this.accountNumber, required this.pending, this.status, required this.createdAt, required this.updatedAt, required this.user});

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      id: json['id'],
      amount: json['amount'],
      accountNumber: json['accountNumber'],
      pending: json['pending'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: User.fromJson(json['user']),
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'accountNumber': accountNumber,
      'pending': pending,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user.toJson(),
    };
  }
}
