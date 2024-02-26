part of '../viewmodels/home_viewmodel.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomePostsLoading extends HomeState {}

class HomePostsLoadingSuccess extends HomeState {
  final List<Post> posts;

  const HomePostsLoadingSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

class HomePostsLoadingFailed extends HomeState {
  final String message;

  const HomePostsLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class ScreenIndexChanged extends HomeState {
  final int index;
  const ScreenIndexChanged(this.index);
  @override
  List<Object> get props => [index];
}
