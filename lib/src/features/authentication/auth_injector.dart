import 'package:instagram/src/config/container_injector.dart';
import 'package:instagram/src/features/authentication/data/datasources/remote_authentication_data_source.dart';
import 'package:instagram/src/features/authentication/data/datasources/remote_authentication_data_source_impl.dart';
import 'package:instagram/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:instagram/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:instagram/src/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:instagram/src/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:instagram/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';

void initAuth() {
  sl.registerLazySingleton<RemoteAuthenticationDatasource>(
    () => RemoteAuthenticationDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
        remoteAuthenticationDatasource: sl(), hiveService: sl()),
  );
  sl.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(authenticationRepository: sl()),
  );
  sl.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(authenticationRepository: sl()),
  );
  sl.registerFactory<AuthenticationViewModel>(
    () => AuthenticationViewModel(
      signup: sl(),
      signIn: sl(),
    ),
  );
}
