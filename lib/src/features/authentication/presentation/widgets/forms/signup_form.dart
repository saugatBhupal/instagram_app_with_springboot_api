import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/utils/app_strings.dart';
import 'package:instagram/src/core/widgets/custom_button.dart';
import 'package:instagram/src/core/widgets/input_fields/contact_field.dart';
import 'package:instagram/src/core/widgets/input_fields/name_field.dart';
import 'package:instagram/src/core/widgets/input_fields/password_field.dart';
import 'package:instagram/src/core/widgets/input_fields/user_name_field.dart';
import 'package:instagram/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:instagram/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late final TextEditingController _contactController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _contactController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
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
          NameField(nameController: _nameController),
          const SizedBox(height: AppSize.s10),
          UsernameField(usernameController: _usernameController),
          const SizedBox(height: AppSize.s10),
          PasswordField(passwordController: _passwordController),
          const SizedBox(height: AppSize.s20),
          BlocBuilder<AuthenticationViewModel, AuthenticationState>(
            builder: (context, state) {
              if (state is SignUpLoading) {
                return const CircularProgressIndicator();
              } else {
                return CustomButton(
                  label: AppStrings.signUp,
                  width: context.width,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUpRequestDto signupParams = SignUpRequestDto(
                        contact: _contactController.text,
                        password: _passwordController.text,
                        fullname: _nameController.text,
                        username: _usernameController.text,
                      );
                      context.read<AuthenticationViewModel>().add(
                            SignUpEvent(signupParams: signupParams),
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
