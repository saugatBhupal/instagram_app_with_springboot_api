import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagram/src/config/bloc_observer.dart';
import 'package:instagram/src/config/app.dart';
import 'package:instagram/src/config/container_injector.dart';
import 'package:instagram/src/config/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  await LocalStorage.init();
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}
