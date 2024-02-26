import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/domain/usecase/base_usecase.dart';
import 'package:instagram/src/features/splash/domain/usecases/get_current_user_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCurrentUserUsecase getCurrentUser;
  SplashBloc({required this.getCurrentUser}) : super(SplashInitial()) {
    on<SplashGetCurrentUser>(splashGetCurrentUser);
  }

  FutureOr<void> splashGetCurrentUser(
      SplashGetCurrentUser event, Emitter<SplashState> emit) async {
    final result = await getCurrentUser(NoParams());
    result.fold((left) => emit(SplashGetUserFailed()),
        (right) => emit(SplashGetUserSuccessfully(user: right)));
  }
}
