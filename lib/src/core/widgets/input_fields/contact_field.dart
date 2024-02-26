import 'package:flutter/material.dart';
import 'package:instagram/src/core/utils/app_colors.dart';

import '../../utils/app_strings.dart';

class ContactFiled extends StatelessWidget {
  final TextEditingController contactController;
  const ContactFiled({super.key, required this.contactController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: contactController,
      cursorColor: AppColors.blue,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      validator: (String? value) {
        if (value!.isEmpty) return AppStrings.contact;
        return null;
      },
      decoration: const InputDecoration(
        labelText: AppStrings.contact,
      ),
    );
  }
}
