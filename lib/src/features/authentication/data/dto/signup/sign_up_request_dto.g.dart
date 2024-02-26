// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestDto _$SignUpRequestDtoFromJson(Map<String, dynamic> json) =>
    SignUpRequestDto(
      fullname: json['fullname'] as String,
      username: json['username'] as String,
      contact: json['contact'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpRequestDtoToJson(SignUpRequestDto instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'username': instance.username,
      'contact': instance.contact,
      'password': instance.password,
    };
