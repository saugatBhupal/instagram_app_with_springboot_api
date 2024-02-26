import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import 'package:instagram/src/features/authentication/presentation/widgets/forms/signin_form.dart';

import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../widgets/auth_instead_of.dart';
import '../widgets/or_separator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationViewModel, AuthenticationState>(
        listener: (context, state) {
          if (state is SignInError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is SignInSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.loggedInnSuccessfully,
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (Route<dynamic> route) => false,
              arguments: state.user,
            );
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s30),
            width: context.width,
            height: context.mainHeight,
            alignment: Alignment.center,
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: AssetImage(AppImages.appName),
                    height: AppSize.s100,
                  ),
                  SizedBox(height: AppSize.s40),
                  SignInForm(),
                  SizedBox(height: AppSize.s30),
                  OrSeparator(),
                  SizedBox(height: AppSize.s30),
                  AuthInsteadOf(
                    authRoute: Routes.signUp,
                    authMessage: AppStrings.notHavingAccount,
                    authMethod: AppStrings.signUp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
