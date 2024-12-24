import 'package:json_annotation/json_annotation.dart';

part 'payment_reponse.g.dart';

@JsonSerializable()
class PaymentResponse {
  String? partnerCode;
  String? orderId;
  String? requestId;
  int? amount;
  int? responseTime;
  String? message;
  int? resultCode;
  String? payUrl;
  String? deeplink;
  String? qrCodeUrl;
  String? applink;
  String? deeplinkMiniApp;
  String? signature;

  PaymentResponse(
      {this.partnerCode,
      this.orderId,
      this.requestId,
      this.amount,
      this.responseTime,
      this.message,
      this.resultCode,
      this.payUrl,
      this.deeplink,
      this.qrCodeUrl,
      this.applink,
      this.deeplinkMiniApp,
      this.signature});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}
