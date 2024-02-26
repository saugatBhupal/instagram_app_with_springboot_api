import 'package:equatable/equatable.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';

import '../../../../core/domain/entities/post/post.dart';

class Profile extends Equatable {
  final User user;
  final List<Post> posts;
  Profile({
    required this.user,
    required this.posts,
  });

  @override
  List<Object> get props => [user, posts];

  Profile copyWith({
    User? user,
    List<Post>? posts,
  }) {
    return Profile(
      user: user ?? this.user,
      posts: posts ?? this.posts,
    );
  }
}
