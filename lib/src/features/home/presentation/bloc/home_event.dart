part of '../viewmodels/home_viewmodel.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadPosts extends HomeEvent {}

class ChangeScreenIndex extends HomeEvent {
  final int index;

  const ChangeScreenIndex(this.index);
}
