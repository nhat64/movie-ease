import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_request.g.dart';

@JsonSerializable()
class PaymentRequest {
  final int amount;
  @JsonKey(name: 'cinema_id')
  final int cinemaId;
  @JsonKey(name: 'show_time_id')
  final int showTimeId;
  String? extraData;

  @JsonKey(name: 'deviceOs')
  String deviceOs;

  @JsonKey(name: 'seat_ids')
  final List<int> selectedSeats;
  final List<FoodOrder>? food;

  PaymentRequest({
    required this.amount,
    required this.cinemaId,
    required this.showTimeId,
    this.extraData,
    required this.selectedSeats,
    this.food,
    this.deviceOs = 'mobile',
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => _$PaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
}

@JsonSerializable()
class FoodOrder {
  @JsonKey(name: 'food_id')
  final int foodId;
  @JsonKey(name: 'food_quantity')
  final int foodQuantity;

  FoodOrder({
    required this.foodId,
    required this.foodQuantity,
  });

  factory FoodOrder.fromJson(Map<String, dynamic> json) => _$FoodOrderFromJson(json);

  Map<String, dynamic> toJson() => _$FoodOrderToJson(this);
}
