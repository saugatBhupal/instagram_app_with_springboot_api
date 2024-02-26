import 'dart:convert';

import 'package:instagram/src/core/domain/entities/user/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.fullname,
    required super.username,
    required super.contact,
    super.password,
    super.sex,
    super.bio,
    super.link,
    super.profileImage,
    super.joinedDate,
    super.token,
    super.numOfFollowers,
    super.numOfFollowings,
    super.numOfPosts,
  });

  User copyWith({
    int? id,
    String? fullname,
    String? username,
    String? contact,
    String? password,
    String? sex,
    String? bio,
    String? link,
    String? profileImage,
    DateTime? joinedDate,
    String? token,
    int? numOfPosts,
    int? numOfFollowers,
    int? numOfFollowings,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      contact: contact ?? this.contact,
      password: password ?? this.password,
      sex: sex ?? this.sex,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      profileImage: profileImage ?? this.profileImage,
      joinedDate: joinedDate ?? this.joinedDate,
      numOfPosts: numOfPosts ?? this.numOfPosts,
      numOfFollowers: numOfFollowers ?? this.numOfFollowers,
      numOfFollowings: numOfFollowings ?? this.numOfFollowings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'username': username,
      'contact': contact,
      'password': password,
      'sex': sex,
      'bio': bio,
      'link': link,
      'profileImage': profileImage,
      'jojinedDate': joinedDate?.millisecondsSinceEpoch,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      fullname: map['fullname'] as String,
      username: map['username'] as String,
      contact: map['contact'] as String,
      password: map['password'] != null ? map['password'] as String : null,
      sex: map['sex'] != null ? map['sex'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      joinedDate: map['joinedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['joinedDate'] as int)
          : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
