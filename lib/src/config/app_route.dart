import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/container_injector.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/utils/app_enums.dart';
import 'package:instagram/src/core/utils/app_strings.dart';
import 'package:instagram/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import 'package:instagram/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:instagram/src/features/authentication/presentation/screens/register_screen.dart';
import 'package:instagram/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:instagram/src/features/home/presentation/screens/home_screen.dart';
import 'package:instagram/src/features/post/presentation/viewmodels/post_viewmodel.dart';
import 'package:instagram/src/features/post/presentation/screens/add_post_screen.dart';
import 'package:instagram/src/features/post/presentation/screens/view_post_comments_screen.dart';
import 'package:instagram/src/features/post/presentation/screens/view_post_screen.dart';
import 'package:instagram/src/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:instagram/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:instagram/src/features/profile/presentation/screens/view_persons_screen.dart';
import 'package:instagram/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:instagram/src/features/splash/presentation/screens/splash_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String home = "/home";
  static const String addPost = "/addPost";
  static const String profileScreen = "/profileScreen";
  static const String viewPost = "/viewPost";
  static const String viewPostComments = "/viewPostComments";
  static const String viewPersons = "/viewPersons";
}

class AppRouter {
  AppRouter._();

  static final _authBloc = sl<AuthenticationViewModel>();
  static final _postBloc = sl<PostViewModel>();

  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SplashBloc>(),
            child: const SplashScreen(),
          ),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationViewModel>.value(
            value: _authBloc,
            child: const RegisterScreen(),
          ),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationViewModel>.value(
            value: _authBloc,
            child: const LoginScreen(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<HomeViewModel>()..add(HomeLoadPosts()),
              ),
              BlocProvider(create: (context) => sl<PostViewModel>()),
            ],
            child: HomeScreen(user: settings.arguments as User),
          ),
        );
      case Routes.addPost:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostViewModel>.value(
            value: _postBloc,
            child: AddPostScreen(
              mediaType: settings.arguments as MediaType,
              user: settings.arguments as User,
            ),
          ),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            personInfo: settings.arguments as User,
          ),
        );
      case Routes.viewPost:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostViewModel>.value(
            value: _postBloc,
            child: ViewPostScreen(
              screensArgs: settings.arguments as PostScreensArgs,
            ),
          ),
        );
      case Routes.viewPostComments:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostViewModel>.value(
            value: _postBloc,
            child: ViewPostCommentsScreen(
                screenArgs: settings.arguments as PostScreensArgs),
          ),
        );
      case Routes.viewPersons:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProfileViewModel>(
            create: (context) => sl<ProfileViewModel>(),
            child: ViewPersonsScreen(
              screenArgs: settings.arguments as PersonsScreenArgs,
              user: settings.arguments as User,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
    }
  }
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.noRoute)),
    );
  }
}
