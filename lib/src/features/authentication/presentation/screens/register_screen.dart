import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/app_route.dart';
import 'package:instagram/src/core/functions/build_toast.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/utils/app_assets.dart';
import 'package:instagram/src/core/utils/app_colors.dart';
import 'package:instagram/src/core/utils/app_enums.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/utils/app_strings.dart';
import 'package:instagram/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import 'package:instagram/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:instagram/src/features/authentication/presentation/widgets/auth_instead_of.dart';
import 'package:instagram/src/features/authentication/presentation/widgets/login_with_facebook.dart';
import 'package:instagram/src/features/authentication/presentation/widgets/or_separator.dart';
import 'package:instagram/src/features/authentication/presentation/widgets/forms/signup_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationViewModel, AuthenticationState>(
        listener: (context, state) {
          if (state is SignupError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is SignUpSuccesss) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.userCreatedSuccessfully,
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.login,
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(AppSize.s30),
            width: context.width,
            height: context.mainHeight,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Image(
                    image: AssetImage(AppImages.appName),
                    height: AppSize.s100,
                  ),
                  const SizedBox(height: AppSize.s5),
                  _buildSignupMessage(context),
                  const SizedBox(height: AppSize.s20),
                  const LoginWithFacebook(
                    backgroundColor: AppColors.blue,
                    iconAndTextColor: AppColors.white,
                  ),
                  const SizedBox(height: AppSize.s20),
                  const OrSeparator(),
                  const SizedBox(height: AppSize.s20),
                  const SignupForm(),
                  const Divider(height: AppSize.s50, thickness: AppSize.s2),
                  const AuthInsteadOf(
                    authRoute: Routes.login,
                    authMessage: AppStrings.havingAccount,
                    authMethod: AppStrings.login,
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

Text _buildSignupMessage(BuildContext context) {
  return Text(
    AppStrings.signupMessage,
    textAlign: TextAlign.center,
    style: Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: AppColors.blackWith40Opacity),
  );
}
