import 'package:instagram/src/features/post/data/datasources/remote/post_datasource.dart';
import 'package:instagram/src/features/post/data/datasources/remote/post_datasource_impl.dart';
import 'package:instagram/src/features/post/data/repositories/post_remote_repository.dart';
import 'package:instagram/src/features/post/domain/repositories/post_repository.dart';
import 'package:instagram/src/features/post/domain/usecases/add_post_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/add_reply_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/get_post_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/like_comment_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/like_post_usecase.dart';

import 'domain/usecases/add_comment_usecase.dart';
import '../../config/container_injector.dart';

import 'presentation/viewmodels/post_viewmodel.dart';

void initPost() {
  sl.registerLazySingleton<PostDataSource>(
    () => PostDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<PostRepository>(
      () => PostRemoteRepository(postDataSource: sl()));
  sl.registerLazySingleton<AddPostUsecase>(
      () => AddPostUsecase(postRepository: sl()));
  sl.registerLazySingleton<AddCommentUseCase>(
      () => AddCommentUseCase(postRepository: sl()));
  sl.registerLazySingleton<AddReplyUsecase>(
      () => AddReplyUsecase(postRepository: sl()));
  sl.registerLazySingleton<GetPostUsecase>(
      () => GetPostUsecase(postRepository: sl()));
  sl.registerLazySingleton<LikeCommentUsecase>(
      () => LikeCommentUsecase(postRepository: sl()));
  sl.registerLazySingleton<LikePostUsecase>(
      () => LikePostUsecase(postRepository: sl()));
  sl.registerFactory(() => PostViewModel(
      addPostUsecase: sl(),
      addCommentUseCase: sl(),
      getPostUsecase: sl(),
      addReplyUsecase: sl(),
      likeCommentUsecase: sl(),
      likePostUsecase: sl()));
}
