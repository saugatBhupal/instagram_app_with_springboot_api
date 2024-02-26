import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';
import 'package:instagram/src/features/post/domain/repositories/post_repository.dart';

class LikePostUsecase extends BaseUseCase<Post, AddLikesRequestDto> {
  final PostRepository postRepository;

  LikePostUsecase({required this.postRepository});
  @override
  Future<Either<Failure, Post>> call(AddLikesRequestDto dto) {
    return postRepository.likePost(dto);
  }
}
