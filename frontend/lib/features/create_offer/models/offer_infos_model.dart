// import '../../message_page/models/message_model.dart';

import '../../message_page/models/message_model.dart';

class OfferResponse {
  final String message;
  final RequestDataResponse data;
  // final RequestModel data;
  // final RequestData data;

  OfferResponse({required this.message, required this.data});

  factory OfferResponse.fromJson(Map<String, dynamic> json) {
    return OfferResponse(
      message: json['message'],
      data: RequestDataResponse.fromJson(json['data']),
      // data: RequestData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class RequestData {
  final String from;
  final String to;
  final double price;
  final double cost;
  final String serviceType;
  final int? conversationId;
  // final Message message;
  final DateTime date;
  // final int? id;

  RequestData({
    required this.from,
    required this.to,
    required this.serviceType,
    required this.price,
    required this.cost,
    this.conversationId,
    // required this.message,
    required this.date,
    // this.id,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      from: json['from'],
      to: json['to'],
      serviceType: json['service'] ?? "",
      price: double.parse(json['price']),
      cost: double.parse(json['cost']),
      // message: Message.fromJson(json['message']),
      conversationId: json['conversation_id'],
      date: DateTime.parse(json['date']),
      // id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'price': price,
      'cost': cost,
      'service': serviceType,
      // 'message': message.toJson(),
      'date': date.toIso8601String(),
      'conversationId': conversationId,
      // 'id': id,
    };
  }
}

class RequestDataResponse {
  final String from;
  final String to;
  final double price;
  final double cost;
  final ReceivedMessageRequest? message;
  final DateTime date;
  final int? id;

  RequestDataResponse({
    required this.from,
    required this.to,
    required this.price,
    required this.cost,
    required this.message,
    required this.date,
    this.id,
  });

  factory RequestDataResponse.fromJson(Map<String, dynamic> json) {
    return RequestDataResponse(
      from: json['from'],
      to: json['to'],
      price: double.parse(json['price']),
      cost: double.parse(json['cost']),
      // message: Message.fromJson(json['message']),
      message: json['message'] is Map ? ReceivedMessageRequest.fromJson(json['message']) : null,
      // messageId: json['message']["id"],
      date: DateTime.parse(json['date']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'price': price,
      'cost': cost,
      'message': message!.toJson(),
      'date': date.toIso8601String(),
      'id': id,
    };
  }
}
