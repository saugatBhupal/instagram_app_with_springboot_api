import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/error/error_handler.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/core/shared_pref/user_shared_prefs.dart';
import '../../../../core/domain/mappers/user_mappers.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/network/connectivity_checker.dart';
import 'package:instagram/src/features/splash/data/datasources/local/local_splash_data_source.dart';
import 'package:instagram/src/features/splash/data/datasources/remote/remote_splash_data_source.dart';
import 'package:instagram/src/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final LocalSplashDataSource localSplashDataSource;
  final RemoteSplashDataSource remoteSplashDataSource;
  final BaseCheckInternetConnectivity baseCheckInternetConnectivity;

  SplashRepositoryImpl({
    required this.localSplashDataSource,
    required this.remoteSplashDataSource,
    required this.baseCheckInternetConnectivity,
  });
  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    User? userPref = await UserSharedPref.getUser();
    if (await baseCheckInternetConnectivity.isConnected()) {
      if (userPref != null) {
        UserModel? userApiModel =
            await remoteSplashDataSource.getCurrentUser(userPref.id);
        User? user = userApiModel!.toDomain();
        return (Right(user));
      } else {
        return const Right(null);
      }
    } else {
      final user = await localSplashDataSource.getCurrentUser(userPref!.id);
      return (Right(user));
    }
  }
}
