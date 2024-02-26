import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_post_request_dto.g.dart';

@JsonSerializable()
class AddPostRequestDto {
  String? content;
  String caption;
  DateTime postDate;
  String? location;
  String? postMedia;
  int user;

  factory AddPostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddPostRequestDtoFromJson(json);

  AddPostRequestDto({
    required this.content,
    required this.caption,
    required this.postDate,
    this.location,
    this.postMedia,
    required this.user,
  });

  Map<String, dynamic> toJson() => _$AddPostRequestDtoToJson(this);
}
