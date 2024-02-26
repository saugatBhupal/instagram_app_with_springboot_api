import 'package:equatable/equatable.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';

class Comment extends Equatable {
  final String? id;
  final String commentText;
  final User userID;
  final List<User>? likes;
  final List<Comment>? replies;
  final String? createdAt;

  const Comment({
    this.id,
    required this.commentText,
    required this.userID,
    this.likes,
    this.replies,
    this.createdAt,
  });

  @override
  List<Object?> get props => [commentText, likes, createdAt];
}
