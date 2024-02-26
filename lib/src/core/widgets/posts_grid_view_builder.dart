import 'package:flutter/material.dart';
import 'package:instagram/src/config/app_route.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../domain/entities/post/post.dart';
import '../utils/app_size.dart';
import 'custom_shimmers.dart';
import 'image_builder.dart';

class PostsShimmerBuilder extends StatelessWidget {
  const PostsShimmerBuilder({super.key, required this.postsCount});

  final int postsCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: postsCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: AppSize.s5,
        mainAxisSpacing: AppSize.s5,
      ),
      itemBuilder: (context, index) {
        return const LightShimmer();
      },
    );
  }
}

class PostsGridViewBuilder extends StatelessWidget {
  const PostsGridViewBuilder({
    super.key,
    required this.posts,
    required this.user,
  });

  final User user;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: AppSize.s5,
        mainAxisSpacing: AppSize.s5,
      ),
      itemBuilder: (context, index) {
        if (posts[index].postMedia.isNotEmpty) {
          return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.viewPost,
                  arguments: PostScreensArgs(
                    post: posts[index],
                    personInfo: user,
                  ),
                );
              },
              child: ImageBuilder(
                imageUrl: posts[index].postMedia,
              ));
        } else {
          return InkWell(
            onTap: () {},
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                if (isReel(posts[index]))
                  const Padding(
                    padding: EdgeInsets.all(AppSize.s10),
                    child: ImageIcon(
                      AssetImage(AppIcons.video),
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  bool isReel(Post post) {
    if (post.postMedia.isEmpty &&
        post.postMedia.isNotEmpty &&
        post.postMedia.length == 1) {
      return true;
    }
    return false;
  }
}
