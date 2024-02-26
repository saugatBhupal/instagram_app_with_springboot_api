import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/http/api_endpoints.dart';
import 'package:instagram/src/core/http/handle_error_response.dart';
import 'package:instagram/src/core/models/post/comment_api_model.dart';
import 'package:instagram/src/core/models/post/post_model.dart';
import 'package:instagram/src/features/post/data/datasources/remote/post_datasource.dart';
import 'package:instagram/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';

class PostDatasourceImpl implements PostDataSource {
  final Dio dio;

  PostDatasourceImpl({required this.dio});
  @override
  Future<PostModel> getPost(int postId) async {
    try {
      final response = await dio.get("${ApiEndpoints.getPost}$postId");
      if (response.statusCode == 200) {
        PostModel postModel = response.data['data'];
        return postModel;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<PostModel> addPost(AddPostRequestDto dto) async {
    try {
      FormData postData = FormData();
      postData.fields.add(MapEntry('post', jsonEncode(dto.toJson())));
      var res = await dio.post(ApiEndpoints.getPost, data: postData);
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String postID = data['_id'];
        PostModel postApiModel = await getPost(postID as int);
        return postApiModel;
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<CommentModel> getCommentById(String commentID) async {
    try {
      final response =
          await dio.get("${ApiEndpoints.getCommentById}$commentID");
      if (response.statusCode == 200) {
        CommentModel commentModel = response.data['data'];
        return commentModel;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<PostModel> addComment(AddCommentRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.addComment, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String postID = data['postID'];
        PostModel postModel = await getPost(postID as int);
        return postModel;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<CommentModel> addReply(AddReplyRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.addReply, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String commentID = data['id'];
        CommentModel commentApiModel = await getCommentById(commentID);
        return commentApiModel;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<PostModel> postLike(AddLikesRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.likes, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String postID = data['postID'];
        PostModel postModel = await getPost(postID as int);
        return postModel;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<CommentModel> commentLike(CommentLikeRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.likeComment, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String commentID = data['id'];
        CommentModel commentApiModel = await getCommentById(commentID);
        return commentApiModel;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
