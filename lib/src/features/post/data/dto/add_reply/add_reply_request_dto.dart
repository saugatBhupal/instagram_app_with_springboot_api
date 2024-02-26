import 'package:json_annotation/json_annotation.dart';

part 'add_reply_request_dto.g.dart';

@JsonSerializable()
class AddReplyRequestDto {
  final String commentText;
  final int userId;
  final int postId;
  final String commentId;

  AddReplyRequestDto({
    required this.commentText,
    required this.userId,
    required this.postId,
    required this.commentId,
  });

  factory AddReplyRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddReplyRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddReplyRequestDtoToJson(this);
}
