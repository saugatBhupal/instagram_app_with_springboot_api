import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/models/post/comment_api_model.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PostModel extends Post {
  PostModel({
    required super.id,
    required super.content,
    required super.caption,
    required super.postDate,
    required super.location,
    required super.postMedia,
    required super.comments,
    required super.likes,
    required super.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] ?? "",
      content: json['content'] ?? "",
      caption: json['caption'] ?? "",
      postDate: json['postDate'] ?? "",
      location: json['content'] ?? "",
      postMedia: json['postMedia'] ?? "",
      comments: (json['comments'] as List<dynamic>?)
              ?.map((comment) =>
                  CommentModel.fromJson(comment as Map<String, dynamic>))
              .toList() ??
          [],
      likes: (json['upvotes'] as List<dynamic>?)
              ?.map((upvote) => UserModel.fromJson(upvote))
              .toList() ??
          [],
      user: UserModel.fromJson(json['publisher'] ?? {}),
    );
  }
}
