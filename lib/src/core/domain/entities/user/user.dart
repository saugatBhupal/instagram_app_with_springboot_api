import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String fullname;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String contact;
  @HiveField(4)
  final String? password;
  @HiveField(5)
  final String? sex;
  @HiveField(6)
  final String? bio;
  @HiveField(7)
  final String? link;
  @HiveField(8)
  final String? profileImage;
  @HiveField(9)
  final DateTime? joinedDate;
  @HiveField(10)
  final String? token;
  @HiveField(11)
  final int? numOfFollowers;
  @HiveField(12)
  final int? numOfFollowings;
  @HiveField(13)
  final int? numOfPosts;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.contact,
    this.password,
    this.sex,
    this.bio,
    this.link,
    this.profileImage,
    this.joinedDate,
    this.token,
    this.numOfFollowers,
    this.numOfFollowings,
    this.numOfPosts,
  });

  @override
  List<Object> get props {
    return [
      id,
      fullname,
      username,
      contact,
    ];
  }

  User copyWith({
    int? id,
    String? fullname,
    String? username,
    String? contact,
    int? numOfPosts,
    int? numOfFollowers,
    int? numOfFollowings,
  }) {
    return User(
      id: id ?? this.id,
      numOfPosts: numOfPosts ?? this.numOfPosts,
      numOfFollowers: numOfFollowers ?? this.numOfFollowers,
      numOfFollowings: numOfFollowings ?? this.numOfFollowings,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      contact: contact ?? this.contact,
    );
  }
}
