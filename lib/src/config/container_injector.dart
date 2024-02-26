import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram/src/core/network/connectivity_checker.dart';
import 'package:instagram/src/core/network/hive_service.dart';
import 'package:instagram/src/core/network/http_service.dart';
import 'package:instagram/src/features/authentication/auth_injector.dart';
import 'package:instagram/src/features/home/home_injector.dart';
import 'package:instagram/src/features/post/post_injector.dart';
import 'package:instagram/src/features/profile/profile_injector.dart';
import 'package:instagram/src/features/splash/splash_injector.dart';

// final sl = GetIt.instance;
GetIt sl = GetIt.instance;

Future<void> initApp() async {
  _initCore();
  initSplash();
  initAuth();
  initHome();
  initPost();
  initProfile();
}

void _initCore() {
  sl.registerSingleton<Dio>(Dio());
  // add connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  // add checkInternetConnectivity
  sl.registerLazySingleton<BaseCheckInternetConnectivity>(
    () => CheckInternetConnectivity(connectivity: sl()),
  );
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<HttpService>(() => HttpService(Dio()));
}
