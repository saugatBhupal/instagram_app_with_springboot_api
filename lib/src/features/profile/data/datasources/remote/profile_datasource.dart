import 'package:instagram/src/core/models/post/post_model.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/features/profile/domain/entities/profile.dart';

abstract class ProfileDatasource {
  Future<Profile> getProfile(int userID);
  Future<List<PostModel>> userPosts(int userID);
  Future<List<UserModel>> getFollowings(int uid);
  Future<List<UserModel>> getFollowers(int uid);
  Future<String> follow(int userID);
  Future<String> unFollow(int userID);
  Future<void> signOut();
}
