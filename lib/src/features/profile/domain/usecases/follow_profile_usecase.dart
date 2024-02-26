import 'package:dartz/dartz.dart';
import 'package:instagram/src/features/profile/domain/repositories/profile_repository.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';

class FollowProfileUseCase extends BaseUseCase<String, int> {
  final ProfileRepository profileRepository;

  FollowProfileUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, String>> call(int params) async {
    return await profileRepository.follow(params);
  }
}
