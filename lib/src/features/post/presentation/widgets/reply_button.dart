import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../viewmodels/post_viewmodel.dart';

class ReplyButton extends StatefulWidget {
  final PostScreensArgs screenArgs;
  const ReplyButton({super.key, required this.screenArgs});

  @override
  State<ReplyButton> createState() => _ReplyButtonState();
}

class _ReplyButtonState extends State<ReplyButton> {
  late final TextEditingController controller;

  bool isFilled = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          builder: (modalContext) => BlocProvider.value(
            value: context.read<PostViewModel>(),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(modalContext).viewInsets.bottom,
              ),
              child: BlocBuilder<PostViewModel, PostState>(
                builder: (context, state) {
                  return SizedBox(
                    height: AppSize.s60,
                    child: StatefulBuilder(
                      builder: (context, setState) => TextFormField(
                        controller: controller,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() => isFilled = true);
                          } else {
                            setState(() => isFilled = false);
                          }
                        },
                        onTap: () {
                          controller.text =
                              "@${widget.screenArgs.comment!.userID.username}";
                        },
                        decoration: InputDecoration(
                          enabledBorder: null,
                          focusedBorder: null,
                          hintText: AppStrings.addCommentMsg,
                          suffix: state is! CommentAddingReply
                              ? TextButton(
                                  onPressed: !isFilled
                                      ? null
                                      : () {
                                          AddReplyRequestDto replyParams =
                                              AddReplyRequestDto(
                                            postId: widget.screenArgs.post.id,
                                            commentId:
                                                widget.screenArgs.comment!.id!,
                                            userId:
                                                widget.screenArgs.post.user.id,
                                            commentText: controller.text,
                                          );
                                          context.read<PostViewModel>().add(
                                                AddReply(replyParams),
                                              );
                                        },
                                  child: Text(
                                    AppStrings.post,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: AppColors.blue),
                                  ),
                                )
                              : const SizedBox(
                                  width: AppSize.s20,
                                  height: AppSize.s20,
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      child: Text(
        AppStrings.reply,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.black.withOpacity(.6)),
      ),
    );
  }
}
