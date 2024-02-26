import 'package:json_annotation/json_annotation.dart';

part 'add_like_request_dto.g.dart';

@JsonSerializable()
class AddLikesRequestDto {
  final int userID;
  final int postID;

  AddLikesRequestDto({required this.userID, required this.postID});

  factory AddLikesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddLikesRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddLikesRequestDtoToJson(this);
}
