part of '../viewmodels/post_viewmodel.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class GetPostSuccess extends PostState {
  final Post post;
  const GetPostSuccess({required this.post});
}

class GetPostFailed extends PostState {
  final String message;
  const GetPostFailed(this.message);
}

class PostLoading extends PostState {
  const PostLoading();
}

class UploadingPost extends PostState {
  const UploadingPost();
}

class UploadPostSuccess extends PostState {
  final Post post;
  const UploadPostSuccess({required this.post});
}

class UploadPostFailed extends PostState {
  final String message;
  const UploadPostFailed(this.message);
}

class SelectedPostMedia extends PostState {
  final List<String> filePath;

  const SelectedPostMedia(this.filePath);
}

class PostVideoSelected extends PostState {
  final String filePath;

  const PostVideoSelected(this.filePath);
}

class PostSelectionFailed extends PostState {
  const PostSelectionFailed();
}

class AddingComment extends PostState {
  const AddingComment();
}

class PostCommentedSuccess extends PostState {
  final Post post;
  const PostCommentedSuccess(this.post);
}

class PostCommentedFailed extends PostState {
  final String message;
  const PostCommentedFailed(this.message);
}

class CommentAddingReply extends PostState {
  const CommentAddingReply();
}

class CommentRepliedSuccess extends PostState {
  final Comment comment;
  const CommentRepliedSuccess(this.comment);
}

class CommentRepliedFailed extends PostState {
  final String message;
  const CommentRepliedFailed(this.message);
}

class PostSendingLike extends PostState {
  final int postId;

  const PostSendingLike(this.postId);
}

class PostLikedFailed extends PostState {
  final String message;
  const PostLikedFailed(this.message);
}

class PostLikedSuccess extends PostState {
  final Post post;
  const PostLikedSuccess(this.post);
}

class CommentSendingLike extends PostState {
  final String commentId;
  const CommentSendingLike(this.commentId);
}

class CommentLikedFailed extends PostState {
  final String message;
  const CommentLikedFailed(this.message);
}

class CommentLikedSuccess extends PostState {
  final Comment comment;
  const CommentLikedSuccess(this.comment);
}
