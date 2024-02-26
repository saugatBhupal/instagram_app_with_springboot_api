import 'package:flutter/material.dart';
import 'package:instagram/src/config/app_route.dart';
import 'package:instagram/src/core/utils/app_assets.dart';
import 'package:instagram/src/core/utils/app_enums.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/utils/app_strings.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: AppSize.s60,
      title: Image.asset(height: AppSize.s44, AppImages.appName),
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case AppStrings.post:
                _selectPostType(context);
                break;
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: AppStrings.post,
              child: Text(AppStrings.post),
            ),
            const PopupMenuItem(
              value: AppStrings.reels,
              child: Text(AppStrings.reels),
            ),
            const PopupMenuItem(
              value: AppStrings.story,
              child: Text(AppStrings.story),
            ),
          ],
          icon: const ImageIcon(AssetImage(AppIcons.add)),
        ),
        IconButton(
          onPressed: () {},
          icon: const ImageIcon(AssetImage(AppIcons.likeOutline)),
        ),
        IconButton(
          onPressed: () {},
          icon: const ImageIcon(AssetImage(AppIcons.messenger)),
        ),
      ],
    );
  }

  Future<dynamic> _selectPostType(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(
                    Routes.addPost,
                    arguments: MediaType.image,
                  );
                },
                child: const Text(AppStrings.image),
              ),
              const SizedBox(height: AppSize.s10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(
                    Routes.addPost,
                    arguments: MediaType.video,
                  );
                },
                child: const Text(AppStrings.video),
              ),
            ],
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s44);
}
