import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/utils/app_strings.dart';
import 'package:instagram/src/core/widgets/custom_button.dart';
import 'package:instagram/src/core/widgets/input_fields/contact_field.dart';
import 'package:instagram/src/core/widgets/input_fields/password_field.dart';
import 'package:instagram/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:instagram/src/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:instagram/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final TextEditingController _contactController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _contactController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ContactFiled(contactController: _contactController),
          const SizedBox(height: AppSize.s10),
          PasswordField(passwordController: _passwordController),
          const SizedBox(height: AppSize.s20),
          BlocBuilder<AuthenticationViewModel, AuthenticationState>(
            builder: (context, state) {
              if (state is SignInLoading) {
                return const CircularProgressIndicator();
              } else {
                return CustomButton(
                  label: AppStrings.signUp,
                  width: context.width,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignInRequestDto signinParams = SignInRequestDto(
                        login: _contactController.text,
                        password: _passwordController.text,
                      );
                      context.read<AuthenticationViewModel>().add(
                            SignInEvent(signinParams: signinParams),
                          );
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
