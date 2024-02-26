import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';

class LocalStorage {
  LocalStorage._();

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserAdapter());
  }
}
