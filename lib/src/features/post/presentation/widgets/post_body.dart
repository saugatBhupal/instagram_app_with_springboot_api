import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/config/screen_args.dart';
import 'package:instagram/src/core/utils/app_size.dart';
import 'package:instagram/src/core/widgets/image_builder.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';
import 'package:instagram/src/features/post/presentation/viewmodels/post_viewmodel.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key? key, required this.screenArgs}) : super(key: key);

  final PostScreensArgs screenArgs;

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    if (widget.screenArgs.post.postMedia.isEmpty) {
      return InkWell(
        onDoubleTap: () {
          AddLikesRequestDto likeParams = AddLikesRequestDto(
            userID: widget.screenArgs.personInfo.id,
            postID: widget.screenArgs.post.id,
          );
          context.read<PostViewModel>().add(LikePost(likeParams));
          context.read<PostViewModel>().add(LikePost(likeParams));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: AppSize.s400,
                viewportFraction: 1.0,
                enableInfiniteScroll:
                    widget.screenArgs.post.postMedia.length > 1 ? true : false,
              ),
              itemCount: widget.screenArgs.post.postMedia.length,
              itemBuilder: (context, index, realIndex) {
                return ImageViewBuilder(
                  imageUrl: widget.screenArgs.post.postMedia[index],
                );
              },
            ),
            if (widget.screenArgs.post.postMedia.length > 1) ...[
              SliderButton(
                buttonCarouselController: buttonCarouselController,
                isNext: false,
              ),
              SliderButton(
                buttonCarouselController: buttonCarouselController,
                isNext: true,
              ),
            ],
          ],
        ),
      );
    } else {
      return Stack(
        children: [
          if (widget.screenArgs.post.postMedia.length > 1) ...[
            SliderButton(
              buttonCarouselController: buttonCarouselController,
              isNext: false,
            ),
            SliderButton(
              buttonCarouselController: buttonCarouselController,
              isNext: true,
            ),
          ],
        ],
      );
    }
  }
}

class SliderButton extends StatelessWidget {
  final bool isNext;
  const SliderButton({
    super.key,
    required this.buttonCarouselController,
    required this.isNext,
  });

  final CarouselController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isNext ? Alignment.centerRight : Alignment.centerLeft,
      child: OutlinedButton(
        onPressed: () {
          if (isNext) {
            buttonCarouselController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          } else {
            buttonCarouselController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          }
        },
        child: Icon(
          isNext ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
          size: AppSize.s40,
        ),
      ),
    );
  }
}
