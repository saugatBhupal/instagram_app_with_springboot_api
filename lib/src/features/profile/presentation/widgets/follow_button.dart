import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_size.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../viewmodels/profile_viewmodel.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.yourFollowings,
    required this.personUid,
  });

  final int personUid;
  final List yourFollowings;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        if (state is ProfileUnFollowing || state is ProfileFollowing) {
          return const SizedBox(
            width: AppSize.s40,
            height: AppSize.s40,
            child: CircularProgressIndicator(),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              if (yourFollowings.contains(personUid)) {
                context
                    .read<ProfileViewModel>()
                    .add(UnFollowProfile(personUid));
              } else {
                context.read<ProfileViewModel>().add(FollowProfile(personUid));
              }
            },
            style: yourFollowings.contains(personUid)
                ? getButtonStyle(context, AppColors.light)
                : getButtonStyle(context, AppColors.blue),
            child: (yourFollowings.contains(personUid)
                ? const Text(AppStrings.following)
                : const Text(AppStrings.follow)),
          );
        }
      },
    );
  }
}

ButtonStyle? getButtonStyle(context, Color color) => ElevatedButton.styleFrom(
      backgroundColor: color,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      foregroundColor: AppColors.black,
      elevation: 0.2,
    );
