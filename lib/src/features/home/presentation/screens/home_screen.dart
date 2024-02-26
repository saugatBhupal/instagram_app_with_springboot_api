import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:instagram/src/features/home/presentation/widgets/home_app_bar.dart';
import 'package:instagram/src/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:instagram/src/features/home/presentation/widgets/post/home_body.dart';
import 'package:instagram/src/features/profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final User user;

  Widget _getHomeBodyModule(int index) {
    switch (index) {
      case 0:
        return HomeBody(user: user);
      case 1:
      // return SearchScreen(currentPersonInfo: user);
      case 4:
        return ProfileScreen(personInfo: user);
      default:
        return HomeBody(user: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      buildWhen: (previous, current) {
        return current is ScreenIndexChanged;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: state is ScreenIndexChanged && state.index != 0
              ? null
              : const HomeScreenAppBar(),
          body: state is! ScreenIndexChanged
              ? HomeBody(user: user)
              : _getHomeBodyModule(state.index),
          bottomNavigationBar: HomeBottomNavBar(user: user),
        );
      },
    );
  }
}
