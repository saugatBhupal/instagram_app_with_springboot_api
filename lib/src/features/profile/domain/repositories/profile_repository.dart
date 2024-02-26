import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile(int userID);
  Future<Either<Failure, List<User>>> getFollowings(int uid);
  Future<Either<Failure, List<User>>> getFollowers(int uid);
  Future<Either<Failure, String>> follow(int userID);
  Future<Either<Failure, String>> unFollow(int userID);
  Future<Either<Failure, void>> signOut();
}
