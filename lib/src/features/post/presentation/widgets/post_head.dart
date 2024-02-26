import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/utils/app_colors.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/utils/app_strings.dart';
import 'package:instagram/src/core/widgets/circle_image_avatar.dart';
import 'package:instagram/src/core/widgets/view_publisher_name_widget.dart';
import 'package:instagram/src/features/post/presentation/viewmodels/post_viewmodel.dart';

class PostHead extends StatelessWidget {
  const PostHead({Key? key, required this.screenArgs}) : super(key: key);

  final PostScreensArgs screenArgs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s5),
      child: Row(
        children: [
          CircleImageAvatar(
            user: screenArgs.post.user,
            radius: AppSize.s20,
          ),
          const SizedBox(width: AppSize.s10),
          ViewPublisherNameWidget(
            user: screenArgs.post.user,
            name: screenArgs.post.user.username,
          ),
          const Spacer(),
          BlocBuilder<PostViewModel, PostState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return BlocProvider.value(
                        value: context.read<PostViewModel>(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (screenArgs.personInfo.id ==
                                screenArgs.post.user.id) ...[
                              SizedBox(
                                width: context.width,
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: ctx,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text(
                                          AppStrings.deleteEnsureMessage,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(ctx);
                                                },
                                                child: Text(
                                                  AppStrings.no,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: AppColors.blue,
                                                      ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  AppStrings.yes,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: AppColors.red),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                  ),
                                  label: Text(
                                    AppStrings.delete,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSize.s10),
                              SizedBox(
                                width: context.width,
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.blue,
                                  ),
                                  label: Text(
                                    AppStrings.edit,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.blue),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_horiz),
              );
            },
          ),
        ],
      ),
    );
  }
}
