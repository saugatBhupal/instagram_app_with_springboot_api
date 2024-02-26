import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemePrefs {
  late SharedPreferences _sharedPreferences;

  Future<Either<Failure, bool>> setTheme(bool value) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setBool('isDarkTheme', value);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> getTheme() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final isDark = _sharedPreferences.getBool('isDarkTheme') ?? false;
      return Right(isDark);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
