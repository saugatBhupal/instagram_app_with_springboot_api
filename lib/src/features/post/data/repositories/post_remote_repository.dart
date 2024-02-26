import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/mappers/post_mappers.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/models/post/comment_api_model.dart';
import 'package:instagram/src/core/models/post/post_model.dart';
import 'package:instagram/src/features/post/data/datasources/remote/post_datasource.dart';
import 'package:instagram/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';
import 'package:instagram/src/features/post/domain/repositories/post_repository.dart';

class PostRemoteRepository implements PostRepository {
  final PostDataSource postDataSource;

  PostRemoteRepository({required this.postDataSource});
  @override
  Future<Either<Failure, Post>> getPost(int postId) async {
    try {
      final PostModel postApiModel = await postDataSource.getPost(postId);
      return Right(postApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> addPost(AddPostRequestDto dto) async {
    try {
      final PostModel postApiModel = await postDataSource.addPost(dto);
      return Right(postApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> addComment(AddCommentRequestDto dto) async {
    try {
      final PostModel postModel = await postDataSource.addComment(dto);
      return Right(postModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> getCommentById(String commentID) async {
    try {
      final CommentModel commentApiModel =
          await postDataSource.getCommentById(commentID);
      return Right(commentApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> addReply(AddReplyRequestDto dto) async {
    try {
      final CommentModel commentModel = await postDataSource.addReply(dto);
      return Right(commentModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> likePost(AddLikesRequestDto dto) async {
    try {
      PostModel hasLiked = await postDataSource.postLike(dto);
      return Right(hasLiked);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> likeComment(
      CommentLikeRequestDto dto) async {
    try {
      CommentModel hasLiked = await postDataSource.commentLike(dto);
      return Right(hasLiked.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
