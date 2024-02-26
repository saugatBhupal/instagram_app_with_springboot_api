import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/src/core/domain/entities/post/comment.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/utils/app_enums.dart';
import 'package:instagram/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:instagram/src/features/post/data/dto/add_votes/add_like_request_dto.dart';
import 'package:instagram/src/features/post/domain/usecases/add_comment_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/add_post_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/add_reply_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/get_post_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/like_comment_usecase.dart';
import 'package:instagram/src/features/post/domain/usecases/like_post_usecase.dart';

part '../bloc/post_event.dart';
part '../bloc/post_state.dart';

class PostViewModel extends Bloc<PostEvent, PostState> {
  final GetPostUsecase getPostUsecase;
  final AddPostUsecase addPostUsecase;
  final AddCommentUseCase addCommentUseCase;
  final AddReplyUsecase addReplyUsecase;
  final LikePostUsecase likePostUsecase;
  final LikeCommentUsecase likeCommentUsecase;
  PostViewModel({
    required this.getPostUsecase,
    required this.addPostUsecase,
    required this.addCommentUseCase,
    required this.addReplyUsecase,
    required this.likePostUsecase,
    required this.likeCommentUsecase,
  }) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is SelectPostMedia) await _selectPostMedia(event, emit);
      if (event is GetPost) await _getPost(event, emit);
      if (event is UploadPost) await _uploadPost(event, emit);
      if (event is AddComment) await _addComment(event, emit);
      if (event is AddReply) await _addReply(event, emit);
      if (event is LikePost) await _sendLike(event, emit);
      if (event is LikeComment) await _sendLikeForComment(event, emit);
    });
  }

  _getPost(GetPost event, Emitter<PostState> emit) async {
    emit(const PostLoading());

    final result = await getPostUsecase(event.postID);
    result.fold(
      (l) => emit(GetPostFailed(l.message)),
      (r) => emit(GetPostSuccess(post: r)),
    );
  }

  Future<void> _uploadPost(UploadPost event, Emitter<PostState> emit) async {
    emit(const UploadingPost());
    final result = await addPostUsecase(event.dto);
    result.fold(
      (failure) => emit(UploadPostFailed(failure.message)),
      (success) => emit(UploadPostSuccess(post: success)),
    );
  }

  List<String>? _imagesPath;
  List<String>? get imagesPaths => _imagesPath;
  String? _videoPath;
  String? get videoPath => _videoPath;

  Future<void> _selectPostMedia(
    SelectPostMedia event,
    Emitter<PostState> emit,
  ) async {
    if (event.mediaType == MediaType.image) {
      final List<XFile>? pickedFile;
      pickedFile = await ImagePicker().pickMultiImage(imageQuality: 70);
      if (pickedFile.isNotEmpty) {
        _imagesPath = pickedFile.map((e) => e.path).toList();
        emit(SelectedPostMedia(_imagesPath!));
      } else {
        emit(const PostSelectionFailed());
      }
    } else {
      final XFile? pickedFile;
      pickedFile = await ImagePicker().pickVideo(
        source: event.imageSource,
        maxDuration: const Duration(seconds: 30),
      );
      if (pickedFile != null) {
        _videoPath = pickedFile.path;
        emit(PostVideoSelected(_videoPath!));
      } else {
        emit(const PostSelectionFailed());
      }
    }
  }

  _addComment(AddComment event, Emitter<PostState> emit) async {
    emit(const AddingComment());

    final result = await addCommentUseCase(event.dto);
    result.fold(
      (l) => emit(PostCommentedFailed(l.message)),
      (r) => emit(PostCommentedSuccess(r)),
    );
  }

  _addReply(AddReply event, Emitter<PostState> emit) async {
    emit(const CommentAddingReply());

    final result = await addReplyUsecase(event.dto);
    result.fold(
      (l) => emit(CommentRepliedFailed(l.message)),
      (r) => emit(CommentRepliedSuccess(r)),
    );
  }

  _sendLike(LikePost event, Emitter<PostState> emit) async {
    emit(PostSendingLike(event.dto.postID));

    final result = await likePostUsecase(event.dto);
    result.fold(
      (l) => emit(PostLikedFailed(l.message)),
      (r) => emit(PostLikedSuccess(r)),
    );
  }

  _sendLikeForComment(LikeComment event, Emitter<PostState> emit) async {
    emit(CommentSendingLike(event.dto.commentID));

    final result = await likeCommentUsecase(event.dto);
    result.fold(
      (l) => emit(CommentLikedFailed(l.message)),
      (r) => emit(CommentLikedSuccess(r)),
    );
  }
}
