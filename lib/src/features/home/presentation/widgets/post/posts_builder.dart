import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/functions/build_toast.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/utils/app_assets.dart';
import 'package:instagram/src/core/utils/app_enums.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/widgets/custom_shimmers.dart';
import 'package:instagram/src/core/widgets/post_view.dart';
import '../../viewmodels/home_viewmodel.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({super.key, required this.currentPersonInfo});

  final User currentPersonInfo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeState>(
      listener: (context, state) {
        if (state is HomePostsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      buildWhen: (previous, current) {
        return current is HomePostsLoadingSuccess ||
            current is HomePostsLoading;
      },
      builder: (context, state) {
        if (state is HomePostsLoading) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const PostShimmer(),
            separatorBuilder: (context, index) => const SizedBox(
              height: AppSize.s10,
            ),
            itemCount: 10,
          );
        }
        if (context.read<HomeViewModel>().posts.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => PostView(
              screenArgs: PostScreensArgs(
                post: context.read<HomeViewModel>().posts[index],
                personInfo: currentPersonInfo,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: AppSize.s10,
            ),
            itemCount: context.read<HomeViewModel>().posts.length,
          );
        } else {
          return Center(
            child: Image(
              width: context.width / 2,
              height: context.height / 2,
              image: const AssetImage(AppImages.noPosts),
            ),
          );
        }
      },
    );
  }
}

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSize.s5),
            child: Row(
              children: [
                CircleShimmer(radius: AppSize.s20),
                SizedBox(width: AppSize.s10),
                LightShimmer(width: AppSize.s100, height: AppSize.s15),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s5),
          LightShimmer(width: context.width, height: AppSize.s400),
          const SizedBox(height: AppSize.s10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleShimmer(radius: AppSize.s15),
                      SizedBox(width: AppSize.s10),
                      CircleShimmer(radius: AppSize.s15),
                      SizedBox(width: AppSize.s10),
                      CircleShimmer(radius: AppSize.s15),
                      SizedBox(width: AppSize.s10),
                      Spacer(),
                      CircleShimmer(radius: AppSize.s15),
                    ],
                  ),
                  const SizedBox(height: AppSize.s10),
                  const LightShimmer(width: AppSize.s100, height: AppSize.s15),
                  const SizedBox(height: AppSize.s10),
                  LightShimmer(width: context.width / 2, height: AppSize.s15),
                  const SizedBox(height: AppSize.s10),
                  const LightShimmer(width: AppSize.s100, height: AppSize.s15),
                ],
              ),
              const SizedBox(height: AppSize.s10),
              LightShimmer(width: context.width, height: AppSize.s40)
            ],
          )
        ],
      ),
    );
  }
}
