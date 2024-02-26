import 'package:dartz/dartz.dart';

import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:instagram/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> signUp(SignUpRequestDto signupParams);
  Future<Either<Failure, User>> signIn(SignInRequestDto signinParams);
}
