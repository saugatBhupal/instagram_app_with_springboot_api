import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';

import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

class LoginWithFacebook extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconAndTextColor;
  const LoginWithFacebook(
      {super.key, this.backgroundColor, this.iconAndTextColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(backgroundColor: backgroundColor),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.facebook, color: iconAndTextColor),
          const SizedBox(width: AppSize.s5),
          Text(
            AppStrings.loginWithFacebook,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: iconAndTextColor),
          ),
        ],
      ),
    );
  }
}
