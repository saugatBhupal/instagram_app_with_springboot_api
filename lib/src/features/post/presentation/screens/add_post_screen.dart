import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/styles/media_query.dart';
import 'package:instagram/src/core/widgets/input_fields/caption_text_field.dart';
import 'package:instagram/src/core/widgets/share_to_widgets.dart';
import 'package:instagram/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:instagram/src/features/post/presentation/viewmodels/post_viewmodel.dart';

import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

class AddPostScreen extends StatefulWidget {
  final User user;
  final MediaType mediaType;
  const AddPostScreen({super.key, required this.mediaType, required this.user});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late final TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    context.read<PostViewModel>().add(SelectPostMedia(
          mediaType: widget.mediaType,
          imageSource: ImageSource.gallery,
        ));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, _textController),
      body: BlocConsumer<PostViewModel, PostState>(
        listener: (context, state) {
          if (state is UploadingPost) {
            showDialog(
                context: context,
                builder: (context) => const CircularProgressIndicator());
          }
          if (state is UploadPostSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.postUploadingSuccessMsg,
            );
            Navigator.pop(context);
            Navigator.pop(context);
          }
          if (state is UploadPostFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        builder: (context, state) {
          final postBloc = context.read<PostViewModel>();
          if (postBloc.imagesPaths != null || postBloc.videoPath != null) {
            return ListView(
              children: [
                if (postBloc.imagesPaths != null)
                  Container(
                    padding: const EdgeInsets.all(AppSize.s10),
                    decoration: const BoxDecoration(
                      color: AppColors.light,
                    ),
                    height: context.height / 4,
                    child: Row(
                      children: [
                        Image(
                          height: context.height / 4,
                          width: context.width / 4,
                          fit: BoxFit.cover,
                          image: FileImage(File(postBloc.imagesPaths!.first)),
                        ),
                        const SizedBox(width: AppSize.s5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CaptionTextField(textController: _textController),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (postBloc.videoPath != null)
                  CaptionTextField(textController: _textController),
                const Divider(),
                const ShareToWidgets(),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(
          BuildContext context, TextEditingController textController) =>
      AppBar(
        title: const Text(AppStrings.newPost),
        actions: [
          TextButton(
            onPressed: () {
              context.read<PostViewModel>().add(
                    UploadPost(
                      dto: AddPostRequestDto(
                        caption: _textController.text,
                        content: "",
                        user: widget.user.id,
                        postDate: DateTime.now().toLocal(),
                      ),
                    ),
                  );
            },
            child: const Text(AppStrings.share),
          ),
        ],
      );
}
