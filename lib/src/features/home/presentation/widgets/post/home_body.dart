import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:instagram/src/features/home/presentation/widgets/post/posts_builder.dart';
import 'package:instagram/src/features/post/presentation/viewmodels/post_viewmodel.dart';

class HomeBody extends StatelessWidget {
  final User user;
  const HomeBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostViewModel, PostState>(
      listener: (context, state) {
        if (state is UploadPostSuccess) {
          context.read<HomeViewModel>().add(HomeLoadPosts());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeViewModel>().add(HomeLoadPosts());
          },
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              PostsBuilder(currentPersonInfo: user),
            ],
          ),
        ),
      ),
    );
  }
}
