part of '../viewmodels/post_viewmodel.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPost extends PostEvent {
  final int postID;

  const GetPost(this.postID);
}

class UploadPost extends PostEvent {
  final AddPostRequestDto dto;

  const UploadPost({required this.dto});
}

class SelectPostMedia extends PostEvent {
  final MediaType mediaType;
  final ImageSource imageSource;

  const SelectPostMedia({required this.mediaType, required this.imageSource});
}

class AddComment extends PostEvent {
  final AddCommentRequestDto dto;

  const AddComment(this.dto);
}

class AddReply extends PostEvent {
  final AddReplyRequestDto dto;

  const AddReply(this.dto);
}

class LikePost extends PostEvent {
  final AddLikesRequestDto dto;

  const LikePost(this.dto);
}

class LikeComment extends PostEvent {
  final CommentLikeRequestDto dto;

  const LikeComment(this.dto);
}
