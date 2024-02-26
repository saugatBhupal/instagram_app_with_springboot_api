import 'package:dartz/dartz.dart';
import 'package:instagram/src/features/profile/domain/repositories/profile_repository.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';

class UnFollowProfileUseCase extends BaseUseCase<String, int> {
  UnFollowProfileUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<Either<Failure, String>> call(int params) async {
    return await profileRepository.unFollow(params);
  }
}
