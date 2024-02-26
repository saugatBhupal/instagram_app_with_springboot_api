import 'package:flutter/material.dart';

import '../../utils/app_strings.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      obscureText: true,
      validator: (String? value) {
        if (value!.isEmpty) return AppStrings.passwordIsRequired;
        return null;
      },
      decoration: const InputDecoration(
        labelText: AppStrings.password,
      ),
    );
  }
}
