import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/domain/mappers/user_mappers.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/models/user/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPref {
  late SharedPreferences _sharedPreferences;
  static const _userKey = "User";
  static const _firstTimeAppOpen = 'firstTimeAppOpen';
  static const _appToken = 'Token';

  static Future setFirstTimeAppOpen(bool status) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setBool(_firstTimeAppOpen, status);
  }

  static Future<bool> getFirstTimeAppOpen() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getBool(_firstTimeAppOpen);
    if (res == null) {
      return true;
    }
    return res;
  }

  static Future<void> setUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userModel = UserModel(
      id: user.id,
      fullname: user.fullname,
      username: user.username,
      contact: user.contact,
      sex: user.sex,
      bio: user.bio,
      link: user.link,
      profileImage: user.profileImage,
      joinedDate: user.joinedDate,
      token: user.token,
    );
    final userJson = userModel.toJson();
    await prefs.setString(_userKey, jsonEncode(userJson));
  }

  static Future<User?> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? res = prefs.getString(_userKey);
      if (res == null) {
        return null;
      }
      final Map<String, dynamic> decodedJson = json.decode(res);
      UserModel userModel = UserModel.fromJson(decodedJson['userInfo']);
      final user = userModel.toDomain();
      print("User: $user");
      return user;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  static Future deleteUser() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_userKey);
  }

  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return Right(token);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
