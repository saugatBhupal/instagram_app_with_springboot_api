import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/functions/build_toast.dart';
import 'package:instagram/src/core/functions/get_suitable_date.dart';
import 'package:instagram/src/core/utils/app_assets.dart';
import 'package:instagram/src/core/utils/app_colors.dart';
import 'package:instagram/src/core/utils/app_enums.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/utils/app_strings.dart';
import 'package:instagram/src/core/widgets/view_publisher_name_widget.dart';
import 'package:instagram/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';
import 'package:instagram/src/features/post/presentation/viewmodels/post_viewmodel.dart';
import 'package:instagram/src/features/post/presentation/widgets/likers_builder.dart';
import 'package:instagram/src/features/post/presentation/widgets/post_item_btn.dart';

class PostFoot extends StatefulWidget {
  final PostScreensArgs screenArgs;
  const PostFoot({Key? key, required this.screenArgs}) : super(key: key);

  @override
  State<PostFoot> createState() => _PostFootState();
}

class _PostFootState extends State<PostFoot> {
  late final TextEditingController controller;
  List<String> likersUid = [];
  List<Comment> comments = [];
  late Post post;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    post = widget.screenArgs.post;
    likersUid = post.likes.map((e) => e.id).cast<String>().toList();
    comments = post.comments.map((e) => e).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostViewModel, PostState>(
      listener: (context, state) async {
        if (state is PostLikedSuccess) {
          if (post.id == state.post.id) {
            post = state.post;
            likersUid =
                state.post.likes.map((e) => e.id).cast<String>().toList();
          }
        }
        if (state is PostCommentedSuccess) {
          if (post.id == state.post.id) {
            comments = state.post.comments.map((e) => e).toList();
          }
        }
        if (state is PostCommentedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is PostLikedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        AddLikesRequestDto likeParams = AddLikesRequestDto(
                          postID: post.id,
                          userID: post.user.id,
                        );
                        context.read<PostViewModel>().add(LikePost(likeParams));
                      },
                      icon: state is! PostSendingLike
                          ? _getIcon(likersUid)
                          : state.postId == post.id
                              ? const CircularProgressIndicator()
                              : _getIcon(likersUid),
                    ),
                    const SizedBox(width: AppSize.s10),
                    IconButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(
                        //   Routes.viewPostComments,
                        //   arguments: widget.screenArgs,
                        // );
                      },
                      icon: const ImageIcon(
                        size: 50,
                        AssetImage(AppIcons.chat),
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    IconButton(
                      onPressed: () {},
                      icon: const ImageIcon(
                        size: 50,
                        AssetImage(AppIcons.send),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const ImageIcon(
                        size: 50,
                        AssetImage(AppIcons.bookmark),
                      ),
                    ),
                  ],
                ),
                PostItemBtn(
                  label: '${likersUid.length} ${AppStrings.likes}',
                  onTap: () {
                    if (post.likes.isEmpty) return;

                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: LikersBuilder(likers: post.likes),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    ViewPublisherNameWidget(
                      user: post.user,
                      name: post.user.username,
                    ),
                    Text(post.caption),
                  ],
                ),
                if (comments.isNotEmpty)
                  PostItemBtn(
                    label:
                        '${AppStrings.viewAll} ${comments.length.toString()} ${AppStrings.comments}',
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      // Routes.viewPostComments,
                      // arguments: widget.screenArgs.copyWith(
                      //   post: post.copyWith(
                      //     comments: comments,
                      //   ),
                      // ),
                      // );
                    },
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSize.s10),
              child: Text(
                getLongestSuitableDate(DateTime.parse(post.postDate as String)),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColors.black.withOpacity(.6)),
              ),
            ),
            SizedBox(
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
                  decoration: InputDecoration(
                    enabledBorder: null,
                    focusedBorder: null,
                    hintText: AppStrings.addCommentMsg,
                    suffix: state is! AddingComment
                        ? TextButton(
                            onPressed: !isFilled
                                ? null
                                : () {
                                    AddCommentRequestDto commentParams =
                                        AddCommentRequestDto(
                                      postId: post.id,
                                      commentText: controller.text,
                                      userId: widget.screenArgs.personInfo.id,
                                    );
                                    context.read<PostViewModel>().add(
                                          AddComment(commentParams),
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
            ),
          ],
        );
      },
    );
  }

  ImageIcon _getIcon(List<String> likersUid) {
    return ImageIcon(
      size: 50,
      color: likersUid.contains(widget.screenArgs.personInfo.id)
          ? AppColors.red
          : AppColors.black,
      AssetImage(
        likersUid.contains(widget.screenArgs.personInfo.id)
            ? AppIcons.like
            : AppIcons.likeOutline,
      ),
    );
  }
}
