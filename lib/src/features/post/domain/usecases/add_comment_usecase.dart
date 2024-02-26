import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:instagram/src/features/post/domain/repositories/post_repository.dart';

class AddCommentUseCase extends BaseUseCase<Post, AddCommentRequestDto> {
  final PostRepository postRepository;

  AddCommentUseCase({required this.postRepository});
  @override
  Future<Either<Failure, Post>> call(AddCommentRequestDto dto) {
    return postRepository.addComment(dto);
  }
}
