import 'package:json_annotation/json_annotation.dart';

part 'cinema_entity.g.dart';

@JsonSerializable()
class CinemaEntity {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  CinemaEntity({
    this.id,
    this.name,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory CinemaEntity.fromJson(Map<String, dynamic> json) => _$CinemaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaEntityToJson(this);
}
