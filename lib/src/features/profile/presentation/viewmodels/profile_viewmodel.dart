import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/follow_profile_usecase.dart';
import '../../domain/usecases/get_profile_followers_usecase.dart';
import '../../domain/usecases/get_profile_followings_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

import '../../domain/usecases/un_follow_profile_usecase.dart';

part '../bloc/profile_event.dart';
part '../bloc/profile_state.dart';

class ProfileViewModel extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final GetProfileFollowingsUseCase getProfileFollowingsUseCase;
  final GetProfileFollowersUseCase getProfileFollowersUseCase;
  final FollowProfileUseCase followProfileUseCase;
  final UnFollowProfileUseCase unFollowProfileUseCase;
  final SignOutUseCase signOutUseCase;

  ProfileViewModel({
    required this.getProfileUseCase,
    required this.getProfileFollowingsUseCase,
    required this.getProfileFollowersUseCase,
    required this.followProfileUseCase,
    required this.unFollowProfileUseCase,
    required this.signOutUseCase,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfile) await _getProfile(event, emit);
      if (event is GetProfileFollowings) {
        await _getProfileFollowings(event, emit);
      }
      if (event is GetProfileFollowers) await _getProfileFollowers(event, emit);
      if (event is FollowProfile) await _followProfile(event, emit);
      if (event is UnFollowProfile) await _unFollowProfile(event, emit);
      if (event is SignOut) await _signOut(event, emit);
    });
  }

  Future<void> _getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final res = await getProfileUseCase(event.uid);
    res.fold(
      (l) => emit(ProfileLoadingFailed(l.message)),
      (r) => emit(ProfileLoadingSuccess(r)),
    );
  }

  Future<void> _getProfileFollowings(
    GetProfileFollowings event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileFollowingsLoading());
    final res = await getProfileFollowingsUseCase(event.uid);
    res.fold(
      (l) => emit(ProfileFollowingsLoadingFailed(l.message)),
      (r) => emit(ProfileFollowingsLoadingSuccess(r)),
    );
  }

  Future<void> _getProfileFollowers(
    GetProfileFollowers event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileFollowersLoading());
    final res = await getProfileFollowersUseCase(event.uid);
    res.fold(
      (l) => emit(ProfileFollowersLoadingFailed(l.message)),
      (r) => emit(ProfileFollowersLoadingSuccess(r)),
    );
  }

  Future<void> _followProfile(
    FollowProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileFollowing());
    final res = await followProfileUseCase(event.userID);
    res.fold(
      (l) => emit(ProfileFollowingFailed(l.message)),
      (r) => emit(ProfileFollowingSuccess(r)),
    );
  }

  Future<void> _unFollowProfile(
    UnFollowProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUnFollowing());
    final res = await unFollowProfileUseCase(event.userID);
    res.fold(
      (l) => emit(ProfileUnFollowingFailed(l.message)),
      (r) => emit(ProfileUnFollowingSuccess(r)),
    );
  }

  _signOut(SignOut event, Emitter<ProfileState> emit) async {
    emit(ProfileSigningOut());
    final res = await signOutUseCase(null);
    res.fold(
      (l) => emit(ProfileSignOutFailed(l.message)),
      (r) => emit(ProfileSignOutSuccess()),
    );
  }
}
