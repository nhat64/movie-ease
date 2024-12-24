import 'package:json_annotation/json_annotation.dart';

part 'account_entity.g.dart';

@JsonSerializable()
class AccountEntity {
  final int id;
  @JsonKey(name: 'role_id')
  final int roleId;
  final String username;
  final String email;
  @JsonKey(name: 'cinema_id')
  final String? cinemaId;
  @JsonKey(name: 'device_token')
  final String? deviceToken;
  final int status;

  AccountEntity({
    required this.id,
    required this.roleId,
    required this.username,
    required this.email,
    this.cinemaId,
    this.deviceToken,
    required this.status,
  });

  factory AccountEntity.fromJson(Map<String, dynamic> json) => _$AccountEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountEntityToJson(this);
}
