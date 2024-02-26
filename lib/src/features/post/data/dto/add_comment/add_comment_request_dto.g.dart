// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentRequestDto _$AddCommentRequestDtoFromJson(
        Map<String, dynamic> json) =>
    AddCommentRequestDto(
      commentText: json['commentText'] as String,
      userId: json['userId'] as int,
      postId: json['postId'] as int,
    );

Map<String, dynamic> _$AddCommentRequestDtoToJson(
        AddCommentRequestDto instance) =>
    <String, dynamic>{
      'commentText': instance.commentText,
      'userId': instance.userId,
      'postId': instance.postId,
    };
