import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/models/post/comment_api_model.dart';
import 'package:instagram/src/core/models/post/post_model.dart';

extension PostModelExtension on PostModel {
  Post toDomain() {
    return Post(
      id: id,
      caption: caption,
      content: content,
      postDate: postDate,
      location: location,
      postMedia: postMedia,
      comments: comments,
      likes: likes,
      user: user,
    );
  }
}

extension PostExtension on Post {
  PostModel fromDomain() {
    return PostModel(
      id: id,
      caption: caption,
      content: content,
      postDate: postDate,
      location: location,
      postMedia: postMedia,
      comments: comments,
      likes: likes,
      user: user,
    );
  }
}

extension CommentExtension on Comment {
  CommentModel fromDomain() => CommentModel(
        id: id,
        commentText: commentText,
        userID: userID,
        likes: likes?.map((e) => e).toList(),
        replies: replies?.map((e) => e).toList(),
        createdAt: createdAt,
      );
}

extension CommentModelExtension on CommentModel {
  Comment toDomain() => Comment(
        id: id,
        commentText: commentText,
        userID: userID,
        likes: likes?.map((e) => e).toList(),
        replies: replies?.map((e) => e).toList(),
        createdAt: createdAt,
      );
}
