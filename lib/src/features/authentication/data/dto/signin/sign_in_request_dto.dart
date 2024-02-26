import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request_dto.g.dart';

@JsonSerializable()
class SignInRequestDto {
  final String login;
  final String password;

  SignInRequestDto({
    required this.login,
    required this.password,
  });

  factory SignInRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestDtoToJson(this);
}
