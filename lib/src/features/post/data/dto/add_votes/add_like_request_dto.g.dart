// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_like_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLikesRequestDto _$AddLikesRequestDtoFromJson(Map<String, dynamic> json) =>
    AddLikesRequestDto(
      userID: json['userID'] as int,
      postID: json['postID'] as int,
    );

Map<String, dynamic> _$AddLikesRequestDtoToJson(AddLikesRequestDto instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'postID': instance.postID,
    };
