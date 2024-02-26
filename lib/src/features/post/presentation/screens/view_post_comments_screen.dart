import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/features/post/presentation/widgets/comment_widget.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../viewmodels/post_viewmodel.dart';

class ViewPostCommentsScreen extends StatelessWidget {
  final PostScreensArgs screenArgs;

  const ViewPostCommentsScreen({
    super.key,
    required this.screenArgs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s10),
        child: BlocConsumer<PostViewModel, PostState>(
          buildWhen: (previous, current) {
            return current is GetPostSuccess || current is PostLoading;
          },
          listener: (context, state) {
            if (state is GetPostFailed) {
              buildToast(toastType: ToastType.error, msg: state.message);
            }
          },
          builder: (context, state) {
            if (screenArgs.post.comments.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: context.width / 3,
                      image: const AssetImage(AppIcons.chat),
                    ),
                    Text(
                      AppStrings.noComments,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PostViewModel>().add(
                        GetPost(screenArgs.post.id),
                      );
                },
                child: state is! PostLoading
                    ? (state is GetPostSuccess
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                screenArgs: screenArgs.copyWith(
                                    comment: state.post.comments[index]),
                                isReply: false,
                                viewRepliesIsEnable: true,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: state.post.comments.length,
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                screenArgs: screenArgs.copyWith(
                                  comment: screenArgs.post.comments[index],
                                ),
                                isReply: false,
                                viewRepliesIsEnable: true,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: screenArgs.post.comments.length,
                          ))
                    : const CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
