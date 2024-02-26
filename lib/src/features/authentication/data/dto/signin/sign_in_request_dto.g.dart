// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequestDto _$SignInRequestDtoFromJson(Map<String, dynamic> json) =>
    SignInRequestDto(
      login: json['login'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInRequestDtoToJson(SignInRequestDto instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
    };
