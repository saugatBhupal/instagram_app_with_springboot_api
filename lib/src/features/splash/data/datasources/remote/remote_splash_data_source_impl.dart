import 'package:dio/dio.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/http/api_endpoints.dart';
import 'package:instagram/src/core/http/handle_error_response.dart';
import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/features/splash/data/datasources/remote/remote_splash_data_source.dart';

class RemoteSplashDataSourceImpl implements RemoteSplashDataSource {
  final Dio dio;

  RemoteSplashDataSourceImpl({required this.dio});
  @override
  Future<UserModel?> getCurrentUser(int? userID) async {
    try {
      final response = await dio.get("${ApiEndpoints.fetchUserByID}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
