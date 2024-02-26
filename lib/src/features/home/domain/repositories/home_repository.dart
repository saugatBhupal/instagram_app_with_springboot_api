import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Post>>> loadPosts();
}
