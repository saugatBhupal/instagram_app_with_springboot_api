// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_vote_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentLikeRequestDto _$CommentLikeRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CommentLikeRequestDto(
      userID: json['userID'] as int,
      commentID: json['commentID'] as String,
    );

Map<String, dynamic> _$CommentLikeRequestDtoToJson(
        CommentLikeRequestDto instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'commentID': instance.commentID,
    };
