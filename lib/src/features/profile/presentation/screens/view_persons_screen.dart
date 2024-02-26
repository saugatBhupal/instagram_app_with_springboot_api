import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/profile/presentation/widgets/persons_builder.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/custom_shimmers.dart';
import '../viewmodels/profile_viewmodel.dart';

class ViewPersonsScreen extends StatefulWidget {
  final User user;
  final PersonsScreenArgs screenArgs;
  const ViewPersonsScreen(
      {super.key, required this.screenArgs, required this.user});

  @override
  State<ViewPersonsScreen> createState() => _ViewPersonsScreenState();
}

class _ViewPersonsScreenState extends State<ViewPersonsScreen> {
  List<User> followers = [];
  List<User> followings = [];

  @override
  void initState() {
    super.initState();
    switch (widget.screenArgs.personsType) {
      case PersonsType.followings:
        context.read<ProfileViewModel>().add(
              GetProfileFollowings(
                widget.screenArgs.uid,
              ),
            );
        break;
      case PersonsType.followers:
        context.read<ProfileViewModel>().add(
              GetProfileFollowers(
                widget.screenArgs.uid,
              ),
            );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.screenArgs.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocConsumer<ProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFollowingsLoadingSuccess) {
            followings = state.followings;
          }
          if (state is ProfileFollowersLoadingSuccess) {
            followers = state.followers;
          }
        },
        buildWhen: (previous, current) {
          return current is ProfileFollowingsLoadingSuccess ||
              current is ProfileFollowersLoadingSuccess;
        },
        builder: (context, state) {
          if (followers.isNotEmpty) {
            return PersonsBuilder(
              user: widget.user,
              followers: followers,
              followings: followings,
              personsType: PersonsType.followers,
            );
          } else if (followings.isNotEmpty) {
            return PersonsBuilder(
              user: widget.user,
              followers: followers,
              followings: followings,
              personsType: PersonsType.followings,
            );
          } else if (state is ProfileFollowingsLoading ||
              state is ProfileFollowersLoading) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: CircleShimmer(radius: AppSize.s30),
                  title: LightShimmer(
                    width: AppSize.s30,
                    height: AppSize.s15,
                  ),
                  trailing: LightShimmer(
                    width: AppSize.s70,
                    height: AppSize.s30,
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSize.s10,
              ),
              itemCount: 10,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

enum PersonsType { followings, followers }
