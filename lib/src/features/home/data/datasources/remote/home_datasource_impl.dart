import 'package:dio/dio.dart';
import 'package:instagram/src/core/error/failure.dart';
import 'package:instagram/src/core/http/api_endpoints.dart';
import 'package:instagram/src/core/http/handle_error_response.dart';
import 'package:instagram/src/core/models/post/post_model.dart';
import 'package:instagram/src/features/home/data/datasources/remote/home_datasource.dart';

class HomeDatasourceImpl implements HomeDatasource {
  final Dio dio;

  HomeDatasourceImpl({required this.dio});
  @override
  Future<List<PostModel>> loadPosts() async {
    try {
      final response = await dio.get(ApiEndpoints.loadPosts);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<PostModel> posts = List<PostModel>.from(
          data.map((post) => PostModel.fromJson(post)),
        );
        return posts;
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
