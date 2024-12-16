import 'package:json_annotation/json_annotation.dart';

part 'cinema_entity.g.dart';

@JsonSerializable()
class CinemaEntity {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'distance')
  final String? distance;

  CinemaEntity({
    required this.id,
    this.name,
    this.address,
    this.distance,
  });

  factory CinemaEntity.fromJson(Map<String, dynamic> json) => _$CinemaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaEntityToJson(this);
}
