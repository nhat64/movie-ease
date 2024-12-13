import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_message_error.g.dart';

@JsonSerializable()
class RegisterMessageError {
  final List<String>? email;
  final List<String>? password;
  final List<String>? name;
  @JsonKey(name: 'phone_number')
  final List<String>? phoneNumber;
  final List<String>? username;
  RegisterMessageError({
    this.email,
    this.password,
    this.name,
    this.phoneNumber,
    this.username,
  });

  factory RegisterMessageError.fromJson(Map<String, dynamic> json) =>
      _$RegisterMessageErrorFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterMessageErrorToJson(this);
}
