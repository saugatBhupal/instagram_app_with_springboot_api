import 'package:hive/hive.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/utils/app_boxes.dart';

class HiveService {
  Future<void> addUserToBox(User user) async {
    var box = await Hive.openBox<User>(AppBoxesName.userBox);
    await box.put(user.id, user);
  }
}
