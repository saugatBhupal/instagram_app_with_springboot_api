import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/src/core/domain/entities/post/post.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/features/home/domain/usecases/load_posts_usecase.dart';

part '../bloc/home_event.dart';
part '../bloc/home_state.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  final LoadPostUsecase loadPostUsecase;
  HomeViewModel({required this.loadPostUsecase}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeLoadPosts) {
        await _loadPosts(event, emit);
      }
      if (event is ChangeScreenIndex) {
        _changeScreenModule(event, emit);
      }
    });
  }
  List<Post> _posts = [];
  List<Post> get posts => _posts;
  Future<void> _loadPosts(HomeLoadPosts event, Emitter<HomeState> emit) async {
    emit(HomePostsLoading());
    final result = await loadPostUsecase(NoParams());
    result.fold((failure) => emit(HomePostsLoadingFailed(failure.message)),
        (data) {
      _posts = data;
      _posts.sort((a, b) {
        final aTime = DateTime.parse(a.postDate as String);
        final bTime = DateTime.parse(b.postDate as String);
        return bTime.compareTo(aTime);
      });
      emit(HomePostsLoadingSuccess(_posts));
    });
  }

  void _changeScreenModule(ChangeScreenIndex event, Emitter<HomeState> emit) {
    emit(ScreenIndexChanged(event.index));
  }
}
