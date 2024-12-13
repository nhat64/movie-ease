
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final int id;
  @JsonKey(name: 'role_id')
  final int roleId;
  final String username;
  final String email;
  @JsonKey(name: 'cinema_id')
  final int? cinemaId;
  @JsonKey(name: 'device_token')
  final String? deviceToken;
  final int status;

  UserEntity({
    required this.id,
    required this.roleId,
    required this.username,
    required this.email,
    this.cinemaId,
    this.deviceToken,
    required this.status,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
