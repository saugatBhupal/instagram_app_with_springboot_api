import 'package:dartz/dartz.dart';
import 'package:instagram/src/features/profile/domain/repositories/profile_repository.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';

class SignOutUseCase extends BaseUseCase<void, void> {
  final ProfileRepository profileRepository;

  SignOutUseCase(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(void params) async {
    return await profileRepository.signOut();
  }
}
