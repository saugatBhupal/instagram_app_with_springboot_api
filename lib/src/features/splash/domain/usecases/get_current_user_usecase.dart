import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/splash/domain/repositories/splash_repository.dart';

class GetCurrentUserUsecase extends BaseUseCase<User?, NoParams> {
  final SplashRepository splashRepository;

  GetCurrentUserUsecase({required this.splashRepository});

  @override
  Future<Either<Failure, User?>> call(NoParams params) {
    return splashRepository.getCurrentUser();
  }
}
