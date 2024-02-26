import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/widgets/posts_grid_view_builder.dart';
import 'package:instagram/src/features/profile/presentation/widgets/profile_options.dart';
import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../domain/entities/profile.dart';
import '../screens/view_persons_screen.dart';
import 'profile_shimmer.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/utils/app_size.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key, required this.user});

  final User user;

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  Profile? profile;
  List<String> yourFollowingsUid = [];

  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().add(GetProfile(
          widget.user.id,
        ));
    context.read<ProfileViewModel>().add(GetProfileFollowings(
          widget.user.id,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
      buildWhen: (previous, current) {
        return current is ProfileLoading || current is ProfileLoadingSuccess;
      },
      listener: (context, state) {
        if (state is ProfileLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is ProfileLoadingSuccess) {
          profile = state.profile;
        }
        if (state is ProfileFollowingsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is ProfileFollowersLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is ProfileFollowingsLoadingSuccess) {
          yourFollowingsUid =
              state.followings.map((e) => e.id).cast<String>().toList();
        }
        if (state is ProfileUnFollowingSuccess) {
          yourFollowingsUid.removeWhere(
            (element) => element == widget.user.id,
          );
          profile = profile?.copyWith(
              user: profile?.user.copyWith(
            numOfFollowers: profile!.user.numOfFollowers! - 1,
          ));
        }
        if (state is ProfileFollowingSuccess) {
          yourFollowingsUid.add(widget.user.id as String);
          profile = profile?.copyWith(
              user: profile?.user.copyWith(
            numOfFollowers: profile!.user.numOfFollowers! + 1,
          ));
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const ProfileShimmer();
        } else if (profile != null) {
          return Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileViewModel>().add(GetProfile(
                      profile!.user.id,
                    ));
                context.read<ProfileViewModel>().add(GetProfileFollowings(
                      widget.user.id,
                    ));
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          CircleImageAvatar(
                            user: profile!.user,
                            radius: AppSize.s40,
                            enableNavigate: false,
                          ),
                          const SizedBox(height: AppSize.s5),
                          Text(
                            profile!.user.username,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BlocBuilder<ProfileViewModel, ProfileState>(
                              buildWhen: (previous, current) {
                                return current is ProfileUnFollowingSuccess ||
                                    current is ProfileFollowingSuccess;
                              },
                              builder: (context, state) {
                                return StatsWidget(
                                  label: AppStrings.followers,
                                  number: profile!.user.numOfFollowers!,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.viewPersons,
                                      arguments: PersonsScreenArgs(
                                        uid: profile!.user.id,
                                        personsType: PersonsType.followers,
                                        title: AppStrings.followers,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            StatsWidget(
                              label: AppStrings.followings,
                              number: profile!.user.numOfFollowings!,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  Routes.viewPersons,
                                  arguments: PersonsScreenArgs(
                                    uid: profile!.user.id,
                                    personsType: PersonsType.followings,
                                    title: AppStrings.followings,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  BioWidget(
                    bio: profile!.user.bio,
                  ),
                  const SizedBox(height: AppSize.s10),
                  ProfileOptions(
                    user: profile!.user,
                    yourFollowings: yourFollowingsUid,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {},
                          shape: const Border(
                            bottom: BorderSide(width: AppSize.s1),
                          ),
                          child: const Icon(Icons.apps_outlined),
                        ),
                      ),
                      const Expanded(
                        child: MaterialButton(
                          onPressed: null,
                          child: Icon(Icons.lock),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  profile!.posts.isNotEmpty
                      ? PostsGridViewBuilder(
                          posts: profile!.posts,
                          user: profile!.user,
                        )
                      : Center(
                          child: Image(
                            width: context.width / 2,
                            height: context.height / 2,
                            image: const AssetImage(AppImages.noPosts),
                          ),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
