import 'package:instagram/src/core/models/post/comment_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment_response_dto.g.dart';

@JsonSerializable()
class AddCommentResponseDto {
  final bool success;
  final String message;
  final CommentModel data;

  AddCommentResponseDto(
      {required this.success, required this.message, required this.data});

  factory AddCommentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AddCommentResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentResponseDtoToJson(this);
}
