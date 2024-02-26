import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/profile/presentation/screens/view_persons_screen.dart';

class PostScreensArgs {
  final Post post;
  final User personInfo;
  final Comment? comment;
  final Comment? reply;

  PostScreensArgs({
    this.comment,
    this.reply,
    required this.post,
    required this.personInfo,
  });

  PostScreensArgs copyWith({
    Post? post,
    User? personInfo,
    Comment? comment,
    Comment? reply,
  }) {
    return PostScreensArgs(
      post: post ?? this.post,
      personInfo: personInfo ?? this.personInfo,
      comment: comment ?? this.comment,
      reply: reply ?? this.reply,
    );
  }
}

class PersonsScreenArgs {
  final int uid;
  final PersonsType personsType;
  final String title;

  PersonsScreenArgs({
    required this.uid,
    required this.personsType,
    required this.title,
  });

  PersonsScreenArgs copyWith({
    int? uid,
    PersonsType? personsType,
    String? title,
  }) {
    return PersonsScreenArgs(
      uid: uid ?? this.uid,
      personsType: personsType ?? this.personsType,
      title: title ?? this.title,
    );
  }
}
