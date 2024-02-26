import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommentModel extends Comment {
  CommentModel({
    super.id,
    required super.commentText,
    required super.userID,
    super.likes,
    super.replies,
    super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      commentText: json['commentText'],
      userID: UserModel.fromJson(json['userID']),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((likes) => UserModel.fromJson(likes as String))
          .toList(),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((reply) => CommentModel.fromJson(reply))
          .toList(),
      createdAt: json['createdAt'],
    );
  }
}
