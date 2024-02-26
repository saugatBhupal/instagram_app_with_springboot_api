import 'package:flutter/material.dart';
import 'package:instagram/src/config/app_route.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/widgets/image_builder.dart';
import 'package:instagram/src/core/widgets/view_publisher_name_widget.dart';

class PersonInfoBtn extends StatelessWidget {
  const PersonInfoBtn({
    super.key,
    required this.personInfo,
  });
  final User personInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.profileScreen,
          arguments: personInfo,
        );
      },
      child: Row(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(AppSize.s20),
              child: ImageBuilder(
                imageUrl: personInfo.profileImage!,
              ),
            ),
          ),
          const SizedBox(width: AppSize.s20),
          ViewPublisherNameWidget(
            user: personInfo,
            name: personInfo.username,
            disableNavigate: true,
          ),
        ],
      ),
    );
  }
}
