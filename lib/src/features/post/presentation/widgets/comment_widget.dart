import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:instagram/src/features/post/presentation/widgets/likers_builder.dart';
import 'package:instagram/src/features/post/presentation/widgets/reply_button.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../../../core/functions/get_suitable_date.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../viewmodels/post_viewmodel.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.screenArgs,
    required this.isReply,
    required this.viewRepliesIsEnable,
  });

  final bool isReply;
  final PostScreensArgs screenArgs;
  final bool viewRepliesIsEnable;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late Comment comment;
  List<int> likersUid = [];
  List<Comment> replies = [];

  @override
  void initState() {
    super.initState();
    if (!widget.isReply) {
      comment = widget.screenArgs.comment!;
      likersUid = comment.likes!.map((e) => e.id).toList();
      replies = comment.replies!.map((e) => e).toList();
    } else {
      comment = widget.screenArgs.reply!;
      likersUid = comment.likes!.map((e) => e.id).toList();
      replies = comment.replies!.map((e) => e).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostViewModel, PostState>(
      listener: (context, state) {
        if (state is CommentLikedSuccess && state.comment.id == comment.id) {
          likersUid = state.comment.likes!.map((e) => e.id).toList();
          comment = state.comment;
        }
        if (state is CommentRepliedSuccess && state.comment.id == comment.id) {
          replies = state.comment.replies!;
          comment = state.comment;
        }
        if (state is CommentRepliedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is CommentLikedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleImageAvatar(user: comment.userID),
              const SizedBox(width: AppSize.s10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: ViewPublisherNameWidget(
                          user: comment.userID,
                          name: comment.userID.username,
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: AppSize.s3),
                          child: Text(
                            comment.commentText,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.black.withOpacity(.8),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s10),
              BlocBuilder<PostViewModel, PostState>(
                buildWhen: (previous, current) {
                  const states = [
                    "Instance of 'CommentSendingLike'",
                    "Instance of 'CommentLikedSuccess'",
                    "Instance of 'CommentLikedFailed'",
                  ];
                  return states.contains(current.toString());
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      if (!widget.isReply) {
                        CommentLikeRequestDto likeParams =
                            CommentLikeRequestDto(
                          userID: widget.screenArgs.post.user.id,
                          commentID: comment.id!,
                        );
                        context
                            .read<PostViewModel>()
                            .add(LikeComment(likeParams));
                      }
                    },
                    icon: state is! CommentSendingLike
                        ? getIcon(likersUid.cast<String>(),
                            widget.screenArgs.personInfo.id)
                        : state.commentId == comment.id
                            ? const CircularProgressIndicator()
                            : getIcon(likersUid.cast<String>(),
                                widget.screenArgs.personInfo.id),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<PostViewModel, PostState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {},
                    child: Text(
                      getShortestSuitableDate(
                          DateTime.parse(comment.createdAt!)),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.black.withOpacity(.6)),
                    ),
                  );
                },
              ),
              BlocBuilder<PostViewModel, PostState>(
                buildWhen: (previous, current) {
                  const states = [
                    "Instance of 'CommentSendingLike'",
                    "Instance of 'CommentLikedSuccess'",
                    "Instance of 'CommentLikedFailed'",
                  ];
                  return states.contains(current.toString());
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (comment.likes!.isEmpty) return;

                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: LikersBuilder(likers: comment.likes!),
                        ),
                      );
                    },
                    child: Text(
                      '${likersUid.length} like',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.black.withOpacity(.6)),
                    ),
                  );
                },
              ),
              if (!widget.isReply)
                ReplyButton(
                  screenArgs: widget.screenArgs.copyWith(comment: comment),
                ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          if (widget.viewRepliesIsEnable && comment.replies!.isNotEmpty)
            BlocBuilder<PostViewModel, PostState>(
              buildWhen: (previous, current) {
                const states = [
                  "Instance of 'CommentAddingReply'",
                  "Instance of 'CommentRepliedSuccess'",
                  "Instance of 'CommentRepliedFailed'",
                ];
                return states.contains(current.toString());
              },
              builder: (context, state) {
                return InkWell(
                  child: Text(
                    '${AppStrings.viewAll} ${replies.length.toString()} ${AppStrings.reply}',
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(
                    //   Routes.viewReplies,
                    //   arguments: widget.screenArgs.copyWith(comment: comment),
                    // );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

Widget getIcon(List<String> likersUid, int userID) {
  bool isReacted = likersUid.contains(userID);
  return ImageIcon(
    size: 50,
    color: isReacted ? AppColors.red : AppColors.black,
    AssetImage(
      isReacted ? AppIcons.like : AppIcons.likeOutline,
    ),
  );
}
