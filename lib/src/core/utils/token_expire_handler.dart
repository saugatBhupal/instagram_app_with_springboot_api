class TokenExpireHandler {
  TokenExpireHandler._internal();

  static final TokenExpireHandler _handler = TokenExpireHandler._internal();

  factory TokenExpireHandler() => _handler;

  bool _isTokenExpireHandled = false;

  handleExpire() {
    if (_isTokenExpireHandled == false) {
      _isTokenExpireHandled = true;
      // SnackBarUtils.showErrorBar(
      //   context: AppRoutes.context,
      //   message: "User Token Expired",
      // );
      // NavigationService.pushNamedAndRemoveUntil(
      //   routeName: Routes.login,
      // );

      Future.delayed(const Duration(seconds: 2)).then((value) {
        _isTokenExpireHandled = false;
      });
    }
  }
}
