import 'package:json_annotation/json_annotation.dart';

part 'comment_vote_request_dto.g.dart';

@JsonSerializable()
class CommentLikeRequestDto {
  final int userID;
  final String commentID;

  CommentLikeRequestDto({required this.userID, required this.commentID});

  factory CommentLikeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CommentLikeRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentLikeRequestDtoToJson(this);
}
