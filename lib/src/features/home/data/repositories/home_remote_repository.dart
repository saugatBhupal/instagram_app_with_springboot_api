import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/mappers/post_mappers.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/models/post/post_model.dart';
import 'package:instagram/src/features/home/data/datasources/remote/home_datasource.dart';
import 'package:instagram/src/features/home/domain/repositories/home_repository.dart';

class HomeRemoteRepository implements HomeRepository {
  final HomeDatasource homeDatasource;

  HomeRemoteRepository({required this.homeDatasource});
  @override
  Future<Either<Failure, List<Post>>> loadPosts() async {
    try {
      List<PostModel> postsModel = await homeDatasource.loadPosts();
      List<Post> posts = postsModel.map((post) => post.toDomain()).toList();
      return Right(posts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
