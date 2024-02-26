import 'package:flutter/material.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/features/post/presentation/widgets/post_body.dart';
import 'package:instagram/src/features/post/presentation/widgets/post_foot.dart';
import 'package:instagram/src/features/post/presentation/widgets/post_head.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class PostView extends StatelessWidget {
  final PostScreensArgs screenArgs;
  const PostView({
    super.key,
    required this.screenArgs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.4,
          color: AppColors.blackWith40Opacity,
        ),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PostHead(screenArgs: screenArgs),
          PostBody(screenArgs: screenArgs),
          PostFoot(screenArgs: screenArgs),
        ],
      ),
    );
  }
}
