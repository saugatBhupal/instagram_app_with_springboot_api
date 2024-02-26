part of '../viewmodel/authentication_viewmodel.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SignUpEvent extends AuthenticationEvent {
  final SignUpRequestDto signupParams;

  const SignUpEvent({required this.signupParams});
  @override
  List<Object?> get props => [signupParams];
}

class SignInEvent extends AuthenticationEvent {
  final SignInRequestDto signinParams;

  const SignInEvent({required this.signinParams});
  @override
  List<Object?> get props => [signinParams];
}
