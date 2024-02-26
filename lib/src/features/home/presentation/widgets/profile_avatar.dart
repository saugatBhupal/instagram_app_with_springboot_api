import 'package:flutter/material.dart';
import 'package:instagram/src/config/container_injector.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/network/connectivity_checker.dart';
import 'package:instagram/src/core/utils/app_assets.dart';
import 'package:instagram/src/core/utils/app_size.dart';

class ProfileAvatar extends StatelessWidget {
  final User user;
  final double? width;
  final double? height;
  final bool showAddBtn;
  const ProfileAvatar(
      {super.key,
      this.width,
      this.height,
      required this.showAddBtn,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<BaseCheckInternetConnectivity>().isConnected(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return _buildImage(NetworkImage(user.profileImage!));
        } else {
          return _buildImage(const AssetImage(AppImages.defaultProfileImage));
        }
      },
    );
  }

  Container _buildImage(ImageProvider image) {
    return Container(
      height: height ?? AppSize.s70,
      width: width ?? AppSize.s70,
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    );
  }
}
