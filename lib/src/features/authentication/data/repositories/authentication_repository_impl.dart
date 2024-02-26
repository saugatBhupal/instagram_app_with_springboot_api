import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/domain/mappers/user_mappers.dart';
import 'package:instagram/src/core/error/error_handler.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/core/network/hive_service.dart';
import 'package:instagram/src/features/authentication/data/datasources/remote_authentication_data_source.dart';
import 'package:instagram/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:instagram/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:instagram/src/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final RemoteAuthenticationDatasource remoteAuthenticationDatasource;
  final HiveService hiveService;

  AuthenticationRepositoryImpl({
    required this.remoteAuthenticationDatasource,
    required this.hiveService,
  });
  @override
  Future<Either<Failure, User>> signUp(SignUpRequestDto signupParams) async {
    try {
      final UserModel user =
          await remoteAuthenticationDatasource.signUp(signupParams);
      hiveService.addUserToBox(user.toDomain());
      return Right(user.toDomain());
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> signIn(SignInRequestDto signinParams) async {
    try {
      final UserModel user =
          await remoteAuthenticationDatasource.signIn(signinParams);
      return Right(user.toDomain());
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }
}
