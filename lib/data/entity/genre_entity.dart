import 'package:json_annotation/json_annotation.dart';

part 'genre_entity.g.dart';

@JsonSerializable()
class GenreEntity {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;

  GenreEntity({required this.id, required this.name, this.description});

  factory GenreEntity.fromJson(Map<String, dynamic> json) =>
      _$GenreEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GenreEntityToJson(this);
}
