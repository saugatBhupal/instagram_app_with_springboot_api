part of '../viewmodels/profile_viewmodel.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadingSuccess extends ProfileState {
  final Profile profile;

  const ProfileLoadingSuccess(this.profile);
}

class ProfileLoadingFailed extends ProfileState {
  final String message;

  const ProfileLoadingFailed(this.message);
}

class ProfileFollowingsLoading extends ProfileState {}

class ProfileFollowingsLoadingSuccess extends ProfileState {
  final List<User> followings;

  const ProfileFollowingsLoadingSuccess(this.followings);
}

class ProfileFollowingsLoadingFailed extends ProfileState {
  final String message;

  const ProfileFollowingsLoadingFailed(this.message);
}

class ProfileFollowersLoading extends ProfileState {}

class ProfileFollowersLoadingSuccess extends ProfileState {
  final List<User> followers;

  const ProfileFollowersLoadingSuccess(this.followers);
}

class ProfileFollowersLoadingFailed extends ProfileState {
  final String message;

  const ProfileFollowersLoadingFailed(this.message);
}

class ProfileFollowing extends ProfileState {}

class ProfileFollowingSuccess extends ProfileState {
  final String uid;

  const ProfileFollowingSuccess(this.uid);
}

class ProfileFollowingFailed extends ProfileState {
  final String message;

  const ProfileFollowingFailed(this.message);
}

class ProfileUnFollowing extends ProfileState {}

class ProfileUnFollowingSuccess extends ProfileState {
  final String uid;

  const ProfileUnFollowingSuccess(this.uid);
}

class ProfileUnFollowingFailed extends ProfileState {
  final String message;

  const ProfileUnFollowingFailed(this.message);
}

class ProfileSigningOut extends ProfileState {}

class ProfileSignOutSuccess extends ProfileState {}

class ProfileSignOutFailed extends ProfileState {
  final String message;

  const ProfileSignOutFailed(this.message);
}
