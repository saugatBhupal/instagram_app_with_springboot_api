import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:instagram/src/features/authentication/domain/repositories/authentication_repository.dart';

class SignInUsecase implements BaseUseCase<User, SignInRequestDto> {
  final AuthenticationRepository authenticationRepository;
  SignInUsecase({required this.authenticationRepository});
  @override
  Future<Either<Failure, User>> call(params) {
    return authenticationRepository.signIn(params);
  }
}
