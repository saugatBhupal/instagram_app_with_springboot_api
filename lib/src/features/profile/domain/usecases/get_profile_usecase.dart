import 'package:dartz/dartz.dart';
import 'package:instagram/src/features/profile/domain/repositories/profile_repository.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/profile.dart';

class GetProfileUseCase extends BaseUseCase<Profile, int> {
  final ProfileRepository profileRepository;

  GetProfileUseCase(this.profileRepository);

  @override
  Future<Either<Failure, Profile>> call(int params) async {
    return await profileRepository.getProfile(params);
  }
}
