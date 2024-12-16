import 'package:json_annotation/json_annotation.dart';

part 'seat_entity.g.dart';

@JsonSerializable()
class SeatEntity {
  @JsonKey(name: 'seat_id')
  final int? id;
  @JsonKey(name: 'seat_code')
  final String? code;
  @JsonKey(name: 'seat_type_id')
  final int? type;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'ticket_price')
  final int? price;

  SeatEntity({
    required this.id,
    required this.code,
    required this.type,
    required this.status,
    required this.price,
  });

  factory SeatEntity.fromJson(Map<String, dynamic> json) => _$SeatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SeatEntityToJson(this);
}
