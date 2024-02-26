part of '../viewmodels/profile_viewmodel.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  final int uid;

  const GetProfile(this.uid);
}

class GetProfileFollowings extends ProfileEvent {
  final int uid;

  const GetProfileFollowings(this.uid);
}

class GetProfileFollowers extends ProfileEvent {
  final int uid;

  const GetProfileFollowers(this.uid);
}

class FollowProfile extends ProfileEvent {
  final int userID;

  const FollowProfile(this.userID);
}

class UnFollowProfile extends ProfileEvent {
  final int userID;

  const UnFollowProfile(this.userID);
}

class SignOut extends ProfileEvent {}
