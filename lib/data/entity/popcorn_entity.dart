import 'package:json_annotation/json_annotation.dart';

part 'popcorn_entity.g.dart';

@JsonSerializable()
class PopcornEntity {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'image')
  final String image;

  PopcornEntity({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.image,
  });

  factory PopcornEntity.fromJson(Map<String, dynamic> json) => _$PopcornEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PopcornEntityToJson(this);
}
