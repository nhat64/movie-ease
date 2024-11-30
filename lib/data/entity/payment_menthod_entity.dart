import 'package:json_annotation/json_annotation.dart';

part 'payment_menthod_entity.g.dart';

@JsonSerializable()
class PaymentMenthodEntity {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'image')
  final String image;

  PaymentMenthodEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  factory PaymentMenthodEntity.fromJson(Map<String, dynamic> json) => _$PaymentMenthodEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMenthodEntityToJson(this);
}
