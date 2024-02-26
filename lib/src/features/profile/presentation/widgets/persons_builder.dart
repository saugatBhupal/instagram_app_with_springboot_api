import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/profile/presentation/widgets/follow_button.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../viewmodels/profile_viewmodel.dart';

import '../../../../config/app_route.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../screens/view_persons_screen.dart';

class PersonsBuilder extends StatefulWidget {
  final User user;
  const PersonsBuilder({
    super.key,
    required this.user,
    required this.followings,
    required this.followers,
    required this.personsType,
  });

  final List<User> followers;
  final List<User> followings;
  final PersonsType personsType;

  @override
  State<PersonsBuilder> createState() => _PersonsBuilderState();
}

class _PersonsBuilderState extends State<PersonsBuilder> {
  late final TextEditingController controller;
  List<User> users = [];
  List<String> yourFollowingsUid = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _checkPersons();
    context.read<ProfileViewModel>().add(GetProfileFollowings(
          widget.user.id,
        ));
  }

  void _checkPersons() {
    switch (widget.personsType) {
      case PersonsType.followings:
        users = widget.followings;
        break;
      case PersonsType.followers:
        users = widget.followers;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: AppStrings.searchAboutSomeone,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSize.s10),
          BlocConsumer<ProfileViewModel, ProfileState>(
            listener: (context, state) {
              if (state is ProfileFollowingsLoadingSuccess) {
                yourFollowingsUid =
                    state.followings.map((e) => e.id).cast<String>().toList();
              }
              if (state is ProfileUnFollowingSuccess) {
                yourFollowingsUid.removeWhere(
                  (element) => element == state.uid,
                );
              }
              if (state is ProfileFollowingSuccess) {
                yourFollowingsUid.add(state.uid);
              }
            },
            builder: (context, state) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: AppSize.s30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        users[index].profileImage!,
                      ),
                    ),
                    title: ViewPublisherNameWidget(
                      user: users[index],
                      disableNavigate: false,
                      name: users[index].username,
                    ),
                    trailing: users[index].id != widget.user.id
                        ? FollowButton(
                            personUid: users[index].id,
                            yourFollowings: yourFollowingsUid,
                          )
                        : null,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.profileScreen,
                        arguments: users[index],
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
