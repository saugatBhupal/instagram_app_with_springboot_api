import 'package:instagram/src/features/home/data/datasources/remote/home_datasource.dart';
import 'package:instagram/src/features/home/data/datasources/remote/home_datasource_impl.dart';
import 'package:instagram/src/features/home/data/repositories/home_remote_repository.dart';
import 'package:instagram/src/features/home/domain/repositories/home_repository.dart';
import 'package:instagram/src/features/home/domain/usecases/load_posts_usecase.dart';

import '../../config/container_injector.dart';
import 'presentation/viewmodels/home_viewmodel.dart';

initHome() {
  sl.registerLazySingleton<HomeDatasource>(
    () => HomeDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRemoteRepository(homeDatasource: sl()),
  );
  sl.registerLazySingleton<LoadPostUsecase>(
    () => LoadPostUsecase(homeRepository: sl()),
  );
  sl.registerFactory<HomeViewModel>(() => HomeViewModel(
        loadPostUsecase: sl(),
      ));
}
