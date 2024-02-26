import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:instagram/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:instagram/src/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:instagram/src/features/authentication/domain/usecases/signup_usecase.dart';

part '../bloc/authentication_event.dart';
part '../bloc/authentication_state.dart';

class AuthenticationViewModel
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignupUsecase signup;
  final SignInUsecase signIn;
  AuthenticationViewModel({required this.signIn, required this.signup})
      : super(AuthenticationInitial()) {
    on<SignUpEvent>(authenticationSignUp);
    on<SignInEvent>(authenticationSignIn);
  }

  FutureOr<void> authenticationSignUp(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(const SignUpLoading());
    final result = await signup(event.signupParams);
    result.fold(
      (failure) => emit(SignupError(failure.message)),
      (success) => emit(SignUpSuccesss(user: success)),
    );
  }

  FutureOr<void> authenticationSignIn(
      SignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(const SignInLoading());
    final result = await signIn(event.signinParams);
    result.fold(
      (failure) => emit(SignInError(message: failure.message)),
      (success) => emit(SignInSuccess(user: success)),
    );
  }
}
