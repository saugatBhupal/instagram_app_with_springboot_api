import 'package:flutter/material.dart';
import 'package:instagram/src/core/domain/entities/user/user.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/shared_pref/user_shared_prefs.dart';

class UserRepository {
  String _token = '';
  String get token => _token;

  final ValueNotifier<User?> _user = ValueNotifier(null);
  ValueNotifier<User?> get user => _user;

  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);
  ValueNotifier<bool> get isLoggedIn => _isLoggedIn;

  Future initialState() async {
    _token = await fetchToken();
    _isLoggedIn.value = _token.isNotEmpty;
    _user.value = await UserSharedPref.getUser();
  }

  Future<String> fetchToken() async {
    try {
      UserSharedPref userSharedPref = UserSharedPref();
      final result = await userSharedPref.getUserToken();
      result.fold(
          (failure) => Failure(message: failure.message), (success) => _token);
      print(_token);
    } on Exception catch (_) {
      print('custom exception is been obtained');
    }
    return _token;
  }
}
