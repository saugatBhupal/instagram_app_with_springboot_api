part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

class SplashGetUserSuccessfully extends SplashState {
  final User? user;

  const SplashGetUserSuccessfully({this.user});
}

class SplashGetUserFailed extends SplashState {}
