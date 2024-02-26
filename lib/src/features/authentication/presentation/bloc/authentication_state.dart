part of '../viewmodel/authentication_viewmodel.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class SignUpLoading extends AuthenticationState {
  const SignUpLoading();

  @override
  List<Object?> get props => [];
}

class SignUpSuccesss extends AuthenticationState {
  final User user;

  const SignUpSuccesss({required this.user});
  @override
  List<Object?> get props => [user];
}

class SignupError extends AuthenticationState {
  final String message;

  const SignupError(this.message);

  @override
  List<Object?> get props => [message];
}

class SignInLoading extends AuthenticationState {
  const SignInLoading();

  @override
  List<Object?> get props => [];
}

class SignInSuccess extends AuthenticationState {
  final User user;
  const SignInSuccess({required this.user});

  @override
  List<Object?> get props => [];
}

class SignInError extends AuthenticationState {
  final String message;

  const SignInError({required this.message});

  @override
  List<Object?> get props => [];
}
