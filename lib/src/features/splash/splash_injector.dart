import 'package:http/http.dart';
import 'package:instagram/src/config/container_injector.dart';
import 'package:instagram/src/features/splash/data/datasources/local/local_splash_data_source_impl.dart';
import 'package:instagram/src/features/splash/data/datasources/local/local_splash_data_source.dart';
import 'package:instagram/src/features/splash/data/datasources/remote/remote_splash_data_source.dart';
import 'package:instagram/src/features/splash/data/datasources/remote/remote_splash_data_source_impl.dart';
import 'package:instagram/src/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:instagram/src/features/splash/domain/repositories/splash_repository.dart';
import 'package:instagram/src/features/splash/domain/usecases/get_current_user_usecase.dart';
import 'package:instagram/src/features/splash/presentation/bloc/splash_bloc.dart';

void initSplash() {
  sl.registerLazySingleton<Client>(() => Client());
  sl.registerLazySingleton<RemoteSplashDataSource>(
      () => RemoteSplashDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<LocalSplashDataSource>(
    () => LocalSplashDataSourceImpl(),
  );
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      localSplashDataSource: sl(),
      remoteSplashDataSource: sl(),
      baseCheckInternetConnectivity: sl(),
    ),
  );
  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(splashRepository: sl()),
  );
  sl.registerFactory<SplashBloc>(
    () => SplashBloc(getCurrentUser: sl()),
  );
}
