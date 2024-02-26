import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:instagram/src/features/post/domain/repositories/post_repository.dart';

class LikeCommentUsecase extends BaseUseCase<Comment, CommentLikeRequestDto> {
  final PostRepository postRepository;

  LikeCommentUsecase({required this.postRepository});
  @override
  Future<Either<Failure, Comment>> call(CommentLikeRequestDto dto) {
    return postRepository.likeComment(dto);
  }
}
