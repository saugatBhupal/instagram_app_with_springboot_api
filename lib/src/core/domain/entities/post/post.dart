import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';

class Post {
  final int id;
  final String content;
  final String caption;
  final DateTime postDate;
  final String location;
  final String postMedia;
  final List<User> likes;
  final List<Comment> comments;
  final User user;

  Post({
    required this.id,
    required this.content,
    required this.caption,
    required this.postDate,
    required this.location,
    required this.postMedia,
    required this.user,
    required this.comments,
    required this.likes,
  });

  Post copyWith({
    int? id,
    String? content,
    String? caption,
    DateTime? postDate,
    String? location,
    String? postMedia,
    List<User>? likes,
    List<Comment>? comments,
    User? user,
  }) {
    return Post(
      id: id ?? this.id,
      content: content ?? this.content,
      caption: caption ?? this.caption,
      postDate: postDate ?? this.postDate,
      location: location ?? this.location,
      postMedia: postMedia ?? this.postMedia,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      user: user ?? this.user,
    );
  }
}
