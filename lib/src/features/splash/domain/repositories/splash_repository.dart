import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/error/failure.dart';

abstract class SplashRepository {
  Future<Either<Failure, User?>> getCurrentUser();
}
