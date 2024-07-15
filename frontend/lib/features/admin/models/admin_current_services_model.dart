import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';
import '../../success_page/models/invoice_model.dart';

class AdminCurrentService {
  final int id;
  final String name;
  final int status;
  final User sender;
  final User receiver;
  final Trip trip;
  final InvoiceModel? invoice;

  AdminCurrentService({
    required this.id,
    required this.name,
    required this.status,
    required this.sender,
    required this.receiver,
    required this.trip,
    required this.invoice,
  });

  factory AdminCurrentService.fromJson(Map<String, dynamic> json) {
    return AdminCurrentService(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      trip: Trip.fromJson(json['trip']),
      invoice: json['invoice'] != null ? InvoiceModel.fromJson(json['invoice']) : null,
    );
  }
}