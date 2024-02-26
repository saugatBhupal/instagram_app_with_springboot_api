import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/profile/presentation/widgets/profile_screen_appbar.dart';
import 'package:instagram/src/features/profile/presentation/widgets/profile_screen_body.dart';
import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';

import '../../../../config/container_injector.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  final User personInfo;

  const ProfileScreen({super.key, required this.personInfo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileViewModel>(
      create: (context) => sl<ProfileViewModel>(),
      child: BlocListener<ProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSignOutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signUp,
              (route) => false,
            );
          }
          if (state is ProfileSignOutFailed) {
            buildToast(
              toastType: ToastType.error,
              msg: state.message,
            );
          }
        },
        child: Scaffold(
          appBar: ProfileScreenAppBar(personInfo: personInfo),
          body: ProfileScreenBody(user: personInfo),
        ),
      ),
    );
  }
}
