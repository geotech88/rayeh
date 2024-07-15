import '../../wallet/models/wallet_model.dart';
import '../../authentication/models/user_model.dart';

class ProfileInfosModel {
  final String message;
  final ProfileData data;

  ProfileInfosModel({
    required this.message,
    required this.data,
  });

  factory ProfileInfosModel.fromJson(Map<String, dynamic> json) {
    return ProfileInfosModel(
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ProfileData {
  final User user;
  final WalletModel wallet;
  final double averageRating;

  ProfileData({
    required this.user,
    required this.wallet,
    required this.averageRating,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      user: User.fromJson(json['user']),
      wallet: WalletModel.fromJson(json['wallet']),
      averageRating: double.parse(json['average_rating'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'wallet': wallet.toJson(),
      'average_rating': averageRating,
    };
  }
}