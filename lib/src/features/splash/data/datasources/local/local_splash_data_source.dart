import 'package:instagram/src/core/domain/entities/user/user.dart';

abstract class LocalSplashDataSource {
  Future<User?> getCurrentUser(int? userID);
}
