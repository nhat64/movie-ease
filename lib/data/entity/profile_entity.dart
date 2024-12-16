import 'package:base_flutter/data/entity/account_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity {
  final int id;
  @JsonKey(name: 'account_id')
  final int accountId;
  final String name;
  final int? age;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String? avatar;
  final AccountEntity account;

  ProfileEntity({
    required this.id,
    required this.accountId,
    required this.name,
    this.age,
    required this.phoneNumber,
    this.avatar,
    required this.account,
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);
}
