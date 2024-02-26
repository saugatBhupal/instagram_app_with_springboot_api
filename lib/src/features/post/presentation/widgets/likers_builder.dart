import 'package:flutter/material.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/utils/app_colors.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/features/post/presentation/widgets/person_info_btn.dart';


class LikersBuilder extends StatelessWidget {
  final List<User> likers;
  const LikersBuilder({super.key, required this.likers});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: context.height / 2,
      width: context.width - AppSize.s50,
      padding: const EdgeInsets.all(AppSize.s10),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final liker = likers[index];
          return PersonInfoBtn(personInfo: liker);
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: likers.length,
      ),
    );
  }
}
