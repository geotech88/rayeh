import '../../authentication/models/user_model.dart';
import '../../wallet/models/wallet_model.dart';

class AdminInfos {
  final String message;
  final AdminData data;

  AdminInfos({required this.message, required this.data});

  factory AdminInfos.fromJson(Map<String, dynamic> json) {
    return AdminInfos(
      message: json['message'],
      data: AdminData.fromJson(json['data']),
    );
  }
}

class AdminData {
  final User user;
  final WalletModel wallet;
  final int numberOfUsers;
  final double totalAmount;

  AdminData({
    required this.user,
    required this.wallet,
    required this.numberOfUsers,
    required this.totalAmount,
  });

  factory AdminData.fromJson(Map<String, dynamic> json) {
    return AdminData(
      user: User.fromJson(json['user']),
      wallet: WalletModel.fromJson(json['wallet']),
      numberOfUsers: json['numberOfUsers'],
      totalAmount: json['totalAmount'],
    );
  }
}
