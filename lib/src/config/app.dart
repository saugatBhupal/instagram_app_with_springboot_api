import 'package:flutter/material.dart';
import 'package:instagram/src/config/app_route.dart';
import 'package:instagram/src/config/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.getRoute,
      theme: getAppTheme(),
    );
  }
}
