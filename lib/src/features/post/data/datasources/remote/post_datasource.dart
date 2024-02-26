import 'package:instagram/src/core/models/post/comment_api_model.dart';
import 'package:instagram/src/core/models/post/post_model.dart';
import 'package:instagram/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';

abstract class PostDataSource {
  Future<PostModel> getPost(int postId);
  Future<PostModel> addPost(AddPostRequestDto dto);
  Future<PostModel> addComment(AddCommentRequestDto dto);
  Future<CommentModel> getCommentById(String commentID);
  Future<CommentModel> addReply(AddReplyRequestDto dto);
  Future<PostModel> postLike(AddLikesRequestDto dto);
  Future<CommentModel> commentLike(CommentLikeRequestDto dto);
}
