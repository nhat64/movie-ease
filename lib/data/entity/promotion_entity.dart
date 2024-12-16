import 'package:json_annotation/json_annotation.dart';

part 'promotion_entity.g.dart';

@JsonSerializable()
class PromotionEntity {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'promo_name')
  final String promoName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'discount')
  final int discount;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'quantity')
  final int quantity;
  
  @JsonKey(name: 'isUsed')
  bool isUsed;

  PromotionEntity({
    required this.id,
    required this.promoName,
    this.description,
    required this.discount,
    required this.startDate,
    required this.endDate,
    required this.quantity,
    required this.isUsed,
  });

  factory PromotionEntity.fromJson(Map<String, dynamic> json) => _$PromotionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionEntityToJson(this);
}
