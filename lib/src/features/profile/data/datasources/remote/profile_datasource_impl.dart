import 'package:dio/dio.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/http/api_endpoints.dart';
import 'package:instagram/src/core/http/handle_error_response.dart';
import 'package:instagram/src/core/models/post/post_model.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/core/shared_pref/user_shared_prefs.dart';
import 'package:instagram/src/features/profile/data/datasources/remote/profile_datasource.dart';
import 'package:instagram/src/features/profile/domain/entities/profile.dart';

class ProfileDatasourceImpl implements ProfileDatasource {
  final Dio dio;

  ProfileDatasourceImpl({required this.dio});
  @override
  Future<String> follow(int userID) async {
    try {
      final response = await dio.post("${ApiEndpoints.follow}$userID");
      if (response.statusCode == 200) {
        final username = response.data['user'];
        return username;
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
  Future<List<UserModel>> getFollowers(int uid) async {
    try {
      final response = await dio.get("${ApiEndpoints.followers}$uid");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<UserModel> users = List<UserModel>.from(
          data.map((user) => UserModel.fromJson(user)),
        );
        return users;
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
  Future<List<UserModel>> getFollowings(int uid) async {
    try {
      final response = await dio.get("${ApiEndpoints.followings}$uid");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<UserModel> users = List<UserModel>.from(
          data.map((user) => UserModel.fromJson(user)),
        );
        return users;
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
  Future<Profile> getProfile(int userID) async {
    try {
      final response = await dio.get("${ApiEndpoints.fetchUserByID}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<PostModel> posts = await userPosts(userID);
        final Profile userProfile = Profile(user: data, posts: posts);
        return userProfile;
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
  Future<String> unFollow(int userID) async {
    try {
      final response = await dio.post("${ApiEndpoints.unfollow}$userID");
      if (response.statusCode == 200) {
        final username = response.data['user'];
        return username;
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
  Future<List<PostModel>> userPosts(int userID) async {
    try {
      final response = await dio.get("${ApiEndpoints.userPost}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<PostModel> posts = List<PostModel>.from(
          data.map((post) => PostModel.fromJson(post)),
        );
        return posts;
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
  Future<void> signOut() async {
    try {
      await UserSharedPref.deleteUser();
    } on Exception catch (_) {
      print('custom exception is been obtained');
    }
  }
}
