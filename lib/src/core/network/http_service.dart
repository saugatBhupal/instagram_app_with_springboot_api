import 'package:dio/dio.dart';
import 'package:instagram/src/core/http/api_endpoints.dart';
import 'package:instagram/src/core/http/dio_service_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json, charset=UTF-8',
      };
  }
}
