// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentResponseDto _$AddCommentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    AddCommentResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: CommentModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddCommentResponseDtoToJson(
        AddCommentResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
