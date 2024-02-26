import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/home/domain/repositories/home_repository.dart';

class LoadPostUsecase extends BaseUseCase<List<Post>, NoParams> {
  final HomeRepository homeRepository;

  LoadPostUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, List<Post>>> call(NoParams dto) {
    return homeRepository.loadPosts();
  }
}
