import 'package:base_flutter/data/entity/account_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity {
  final int id;
  @JsonKey(name: 'account_id')
  final int accountId;
  final String name;
  final String? age;
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

  ProfileEntity copyWith({
    int? id,
    int? accountId,
    String? name,
    String? age,
    String? phoneNumber,
    String? avatar,
    AccountEntity? account,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      account: account ?? this.account,
    );
  }
}
