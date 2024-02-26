import 'package:hive/hive.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';

class AppBoxesName {
  AppBoxesName._();
  static const String userBox = 'userBox';
}

class AppBoxes {
  AppBoxes._();
  static Box<User> get userBox => Hive.box<User>(AppBoxesName.userBox);
}

class AppBoxesKeys {
  AppBoxesKeys._();
  static const String user = 'user';
}
