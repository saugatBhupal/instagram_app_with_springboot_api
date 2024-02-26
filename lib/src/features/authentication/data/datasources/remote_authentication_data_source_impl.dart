import 'package:dio/dio.dart';
import 'package:instagram/src/core/error/exceptions.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/http/api_endpoints.dart';
import 'package:instagram/src/core/http/handle_error_response.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/core/shared_pref/user_shared_prefs.dart';
import 'package:instagram/src/features/authentication/data/datasources/remote_authentication_data_source.dart';
import 'package:instagram/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:instagram/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';

class RemoteAuthenticationDatasourceImpl
    extends RemoteAuthenticationDatasource {
  final Dio dio;

  RemoteAuthenticationDatasourceImpl({required this.dio});

  @override
  Future<UserModel> signUp(SignUpRequestDto signupParams) async {
    try {
      var res =
          await dio.post(ApiEndpoints.register, data: signupParams.toJson());
      if (res.statusCode == 200) {
        final data = res.data['data'];
        final UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<UserModel> signIn(SignInRequestDto signinParams) async {
    try {
      var res = await dio.post(ApiEndpoints.login, data: signinParams.toJson());
      if (res.statusCode == 200) {
        final data = res.data['data'];
        final UserModel user = UserModel.fromJson(data);
        final UserSharedPref userSharedPref = UserSharedPref();
        userSharedPref.setUserToken(user.token!);
        return user;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
