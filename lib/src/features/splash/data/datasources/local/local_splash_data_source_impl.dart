import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/shared_pref/user_shared_prefs.dart';
import 'package:instagram/src/features/splash/data/datasources/local/local_splash_data_source.dart';

class LocalSplashDataSourceImpl implements LocalSplashDataSource {
  @override
  Future<User?> getCurrentUser(int? userID) async {
    User? userPref = await UserSharedPref.getUser();
    return userPref;
  }
}
