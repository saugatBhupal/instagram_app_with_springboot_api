// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPostResponseDto _$AddPostResponseDtoFromJson(Map<String, dynamic> json) =>
    AddPostResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: PostModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddPostResponseDtoToJson(AddPostResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
