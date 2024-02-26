import 'package:json_annotation/json_annotation.dart';

part 'add_comment_request_dto.g.dart';

@JsonSerializable()
class AddCommentRequestDto {
  final String commentText;
  final int userId;
  final int postId;

  AddCommentRequestDto({
    required this.commentText,
    required this.userId,
    required this.postId,
  });

  factory AddCommentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddCommentRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentRequestDtoToJson(this);
}
