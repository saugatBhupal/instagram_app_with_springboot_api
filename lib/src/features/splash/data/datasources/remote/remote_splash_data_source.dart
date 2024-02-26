import 'package:instagram/src/core/models/user/user_model.dart';

abstract class RemoteSplashDataSource {
  Future<UserModel?> getCurrentUser(int? userID);
}
