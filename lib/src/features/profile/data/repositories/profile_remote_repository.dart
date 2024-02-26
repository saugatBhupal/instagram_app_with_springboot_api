import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/domain/mappers/user_mappers.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/features/profile/data/datasources/remote/profile_datasource.dart';
import 'package:instagram/src/features/profile/domain/entities/profile.dart';
import 'package:instagram/src/features/profile/domain/repositories/profile_repository.dart';

class ProfileRemoteRepository implements ProfileRepository {
  final ProfileDatasource profileDatasource;

  ProfileRemoteRepository({required this.profileDatasource});
  @override
  Future<Either<Failure, String>> follow(int userID) async {
    try {
      String username = await profileDatasource.follow(userID);
      return Right(username);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFollowers(int uid) async {
    try {
      List<UserModel> userModel = await profileDatasource.getFollowers(uid);
      List<User> users = userModel.map((user) => user.toDomain()).toList();
      return Right(users);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFollowings(int uid) async {
    try {
      List<UserModel> userModel = await profileDatasource.getFollowers(uid);
      List<User> users = userModel.map((user) => user.toDomain()).toList();
      return Right(users);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfile(int userID) async {
    try {
      Profile profile = await profileDatasource.getProfile(userID);
      return Right(profile);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await profileDatasource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> unFollow(int userID) async {
    try {
      String username = await profileDatasource.unFollow(userID);
      return Right(username);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
