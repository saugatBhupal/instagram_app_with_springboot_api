import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_dto.g.dart';

@JsonSerializable()
class SignUpRequestDto {
  final String fullname;
  final String username;
  final String contact;
  final String password;

  SignUpRequestDto({
    required this.fullname,
    required this.username,
    required this.contact,
    required this.password,
  });

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestDtoToJson(this);
}
