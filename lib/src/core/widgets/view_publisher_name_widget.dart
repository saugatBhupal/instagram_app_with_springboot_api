import 'package:flutter/material.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import '../../config/app_route.dart';

import '../utils/app_fonts.dart';
import '../utils/app_size.dart';

class ViewPublisherNameWidget extends StatelessWidget {
  const ViewPublisherNameWidget({
    Key? key,
    required this.user,
    required this.name,
    this.disableNavigate,
    this.textColor,
    this.addPadding,
  }) : super(key: key);
  final User user;
  final bool? disableNavigate;
  final String name;
  final Color? textColor;
  final bool? addPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: addPadding == null
          ? const EdgeInsets.symmetric(
              horizontal: AppSize.s10,
              vertical: AppSize.s5,
            )
          : EdgeInsets.zero,
      child: InkWell(
        onTap: disableNavigate != null
            ? null
            : () {
                Navigator.of(context).pushNamed(
                  Routes.profileScreen,
                  arguments: user,
                );
              },
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontThickness.bold,
                color: textColor,
              ),
        ),
      ),
    );
  }
}
