import 'package:flutter/material.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'follow_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/utils/app_size.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({
    Key? key,
    required this.user,
    required this.yourFollowings,
  }) : super(key: key);

  final User user;
  final List yourFollowings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {},
            style: getButtonStyle(context, AppColors.light),
            child: const Text(AppStrings.editProfile),
          ),
        ),
        Expanded(
          child:
              FollowButton(yourFollowings: yourFollowings, personUid: user.id),
        ),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: getButtonStyle(context, AppColors.blue),
            child: const Text(AppStrings.message),
          ),
        )
      ],
    );
  }
}

ButtonStyle? getButtonStyle(context, Color color) => ElevatedButton.styleFrom(
      backgroundColor: color,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      foregroundColor: AppColors.black,
      elevation: 0.2,
    );

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required this.label,
    required this.number,
    this.onTap,
  });

  final void Function()? onTap;
  final String label;
  final int number;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            number.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class BioWidget extends StatelessWidget {
  const BioWidget({super.key, this.bio});

  final String? bio;

  @override
  Widget build(BuildContext context) {
    if (bio != null && bio!.isNotEmpty) {
      return Text.rich(
        TextSpan(text: bio),
        style: Theme.of(context).textTheme.titleMedium,
      );
    } else {
      return const SizedBox();
    }
  }
}
