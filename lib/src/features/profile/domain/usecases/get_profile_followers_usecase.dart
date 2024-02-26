import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/profile/domain/repositories/profile_repository.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';

class GetProfileFollowersUseCase extends BaseUseCase<List<User>, int> {
  final ProfileRepository profileRepository;

  GetProfileFollowersUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, List<User>>> call(int params) async {
    return await profileRepository.getFollowers(params);
  }
}
