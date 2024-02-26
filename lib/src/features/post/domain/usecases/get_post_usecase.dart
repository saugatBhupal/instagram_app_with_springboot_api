import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/post/domain/repositories/post_repository.dart';

class GetPostUsecase extends BaseUseCase<Post, int> {
  final PostRepository postRepository;

  GetPostUsecase({required this.postRepository});
  @override
  Future<Either<Failure, Post>> call(int dto) {
    return postRepository.getPost(dto);
  }
}
