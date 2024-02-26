// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPostRequestDto _$AddPostRequestDtoFromJson(Map<String, dynamic> json) =>
    AddPostRequestDto(
      content: json['content'] as String?,
      caption: json['caption'] as String,
      postDate: DateTime.parse(json['postDate'] as String),
      location: json['location'] as String?,
      postMedia: json['postMedia'] as String?,
      user: json['user'] as int,
    );

Map<String, dynamic> _$AddPostRequestDtoToJson(AddPostRequestDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'caption': instance.caption,
      'postDate': instance.postDate.toIso8601String(),
      'location': instance.location,
      'postMedia': instance.postMedia,
      'user': instance.user,
    };
