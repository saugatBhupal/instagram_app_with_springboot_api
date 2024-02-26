import 'package:flutter/material.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import '../../config/app_route.dart';

import '../utils/app_size.dart';
import 'image_builder.dart';

class CircleImageAvatar extends StatelessWidget {
  final double? radius;
  final bool? enableNavigate;
  const CircleImageAvatar({
    super.key,
    required this.user,
    this.radius,
    this.enableNavigate,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enableNavigate != null && !enableNavigate!
          ? null
          : () {
              Navigator.of(context).pushNamed(
                Routes.profileScreen,
                arguments: user,
              );
            },
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(radius ?? AppSize.s20),
          child: ImageBuilder(
            imageUrl: user.profileImage!,
          ),
        ),
      ),
    );
  }
}
