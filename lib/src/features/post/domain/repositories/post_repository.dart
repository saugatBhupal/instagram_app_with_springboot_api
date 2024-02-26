import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';

abstract class PostRepository {
  Future<Either<Failure, Post>> getPost(int postId);
  Future<Either<Failure, Post>> addPost(AddPostRequestDto dto);
  Future<Either<Failure, Post>> addComment(AddCommentRequestDto dto);
  Future<Either<Failure, Comment>> getCommentById(String commentID);
  Future<Either<Failure, Comment>> addReply(AddReplyRequestDto dto);
  Future<Either<Failure, Post>> likePost(AddLikesRequestDto dto);
  Future<Either<Failure, Comment>> likeComment(CommentLikeRequestDto dto);
}
