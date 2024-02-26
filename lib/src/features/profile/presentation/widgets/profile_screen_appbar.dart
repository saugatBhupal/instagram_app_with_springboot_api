import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';

import '../../../../core/utils/app_size.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileScreenAppBar({super.key, required this.personInfo});

  final User personInfo;

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s44);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Text(
              personInfo.username,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(AppSize.s5),
              child: Icon(Icons.keyboard_arrow_down),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(AppSize.s5),
              child: Icon(
                Icons.menu,
                size: AppSize.s30,
              ),
            ),
          ),
          InkWell(
            onTap: () => context.read<ProfileViewModel>().add(SignOut()),
            child: const Padding(
              padding: EdgeInsets.all(AppSize.s5),
              child: Icon(Icons.logout, size: AppSize.s30),
            ),
          ),
        ],
      ),
    );
  }
}
