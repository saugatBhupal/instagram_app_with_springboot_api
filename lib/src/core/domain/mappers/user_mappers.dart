import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/models/user/user_model.dart';

extension UserModelExtension on UserModel {
  User toDomain() {
    return User(
      id: id,
      fullname: fullname,
      username: username,
      contact: contact,
      password: password,
      sex: sex,
      bio: bio,
      link: link,
      profileImage: profileImage,
      joinedDate: joinedDate,
      token: token,
    );
  }
}

extension UserExtension on User {
  UserModel fromDomain() {
    return UserModel(
      id: id,
      fullname: fullname,
      username: username,
      contact: contact,
      password: password,
      sex: sex,
      bio: bio,
      link: link,
      profileImage: profileImage,
      joinedDate: joinedDate,
      token: token,
    );
  }
}
