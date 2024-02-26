// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_reply_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReplyRequestDto _$AddReplyRequestDtoFromJson(Map<String, dynamic> json) =>
    AddReplyRequestDto(
      commentText: json['commentText'] as String,
      userId: json['userId'] as int,
      postId: json['postId'] as int,
      commentId: json['commentId'] as String,
    );

Map<String, dynamic> _$AddReplyRequestDtoToJson(AddReplyRequestDto instance) =>
    <String, dynamic>{
      'commentText': instance.commentText,
      'userId': instance.userId,
      'postId': instance.postId,
      'commentId': instance.commentId,
    };
