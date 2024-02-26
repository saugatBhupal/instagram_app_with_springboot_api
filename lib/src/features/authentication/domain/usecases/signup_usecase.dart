import 'package:dartz/dartz.dart';

import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:instagram/src/features/authentication/domain/repositories/authentication_repository.dart';

class SignupUsecase implements BaseUseCase<User, SignUpRequestDto> {
  final AuthenticationRepository authenticationRepository;

  SignupUsecase({required this.authenticationRepository});

  @override
  Future<Either<Failure, User>> call(SignUpRequestDto params) {
    return authenticationRepository.signUp(params);
  }
}
