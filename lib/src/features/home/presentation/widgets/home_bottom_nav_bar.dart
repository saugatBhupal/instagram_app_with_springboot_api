import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/utils/app_assets.dart';
import 'package:instagram/src/core/utils/app_colors.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/utils/app_strings.dart';
import 'package:instagram/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:instagram/src/features/home/presentation/widgets/profile_avatar.dart';

class HomeBottomNavBar extends StatelessWidget {
  final User user;
  const HomeBottomNavBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.black,
          onTap: (index) {
            context.read<HomeViewModel>().add(ChangeScreenIndex(index));
          },
          items: [
            _bottomNavIcon(AppIcons.home, AppStrings.home),
            _bottomNavIcon(AppIcons.searchOutline, AppStrings.search),
            _bottomNavIcon(AppIcons.videoOutline, AppStrings.reels),
            _bottomNavIcon(AppIcons.shoppingBagOutline, AppStrings.store),
            BottomNavigationBarItem(
              icon: ProfileAvatar(
                user: user,
                showAddBtn: false,
                width: AppSize.s25,
                height: AppSize.s25,
              ),
              label: AppStrings.profile,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavIcon(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(iconPath),
        size: AppSize.s20,
        color: AppColors.black,
      ),
      label: label,
    );
  }
}
