import 'package:instagram/src/features/profile/data/datasources/remote/profile_datasource.dart';
import 'package:instagram/src/features/profile/data/datasources/remote/profile_datasource_impl.dart';
import 'package:instagram/src/features/profile/data/repositories/profile_remote_repository.dart';
import 'package:instagram/src/features/profile/domain/repositories/profile_repository.dart';

import 'domain/usecases/follow_profile_usecase.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'presentation/viewmodels/profile_viewmodel.dart';

import '../../config/container_injector.dart';
import 'domain/usecases/get_profile_followers_usecase.dart';
import 'domain/usecases/get_profile_followings_usecase.dart';
import 'domain/usecases/un_follow_profile_usecase.dart';

void initProfile() {
  sl.registerLazySingleton<ProfileDatasource>(
    () => ProfileDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRemoteRepository(profileDatasource: sl()),
  );
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(sl()),
  );
  sl.registerLazySingleton<GetProfileFollowingsUseCase>(
    () => GetProfileFollowingsUseCase(sl()),
  );
  sl.registerLazySingleton<GetProfileFollowersUseCase>(
    () => GetProfileFollowersUseCase(profileRepository: sl()),
  );

  sl.registerLazySingleton<FollowProfileUseCase>(
    () => FollowProfileUseCase(profileRepository: sl()),
  );
  sl.registerLazySingleton<UnFollowProfileUseCase>(
    () => UnFollowProfileUseCase(sl()),
  );
  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(sl()),
  );
  sl.registerFactory<ProfileViewModel>(() => ProfileViewModel(
        getProfileUseCase: sl(),
        getProfileFollowersUseCase: sl(),
        getProfileFollowingsUseCase: sl(),
        followProfileUseCase: sl(),
        unFollowProfileUseCase: sl(),
        signOutUseCase: sl(),
      ));
}
