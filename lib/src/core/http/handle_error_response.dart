import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instagram/src/core/http/custom_exception.dart';
import 'package:instagram/src/core/utils/token_expire_handler.dart';

handleErrorResponse(DioException e) async {
  if (e.response?.statusCode == 401) {
    TokenExpireHandler().handleExpire();
  }
  if (e.toString().toLowerCase().contains("socketexception")) {
    throw NoInternetException('No Internet connection');
  } else {
    if (e.response != null) {
      return await _response(e.response!, "");
    } else {
      throw FetchDataException('An error occurred while fetching data.');
    }
  }
}

Future<Map<String, dynamic>> _response(Response response, String url,
    {bool cacheResult = false}) async {
  final Map<String, dynamic> res = response.data is Map ? response.data : {};
  final responseJson = <String, dynamic>{};
  responseJson['data'] = res;

  responseJson['statusCode'] = response.statusCode;
  switch (response.statusCode) {
    case 200:
      if (cacheResult) {
        try {
          // await SharedPref.setRestApiData(url, json.encode(res));
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      return responseJson;
    case 204:
      return responseJson;
    case 201:
      return responseJson;
    case 400:
      throw BadRequestException(
        getErrorMessage(res),
        response.statusCode,
      );
    case 401:
    case 402:
      throw UnauthorizedException(
        getErrorMessage(res),
        response.statusCode,
      );
    case 403:
      throw ForbiddenException(
        getErrorMessage(res),
        response.statusCode,
      );
    case 404:
      throw ResourceNotFoundException(
          getErrorMessage(res), response.statusCode);
    case 409:
      throw ResourceNotFoundException(
        getErrorMessage(res),
        response.statusCode,
      );
    case 422:
      responseJson['error'] = getErrorMessage(res);
      throw BadRequestException(
        getErrorMessage(res),
        response.statusCode,
      );
    case 500:
      throw InternalServerErrorException(
        getErrorMessage(res),
        response.statusCode,
      );
    default:
      throw NoInternetException(
        'Error occured while Communication with Server',
        response.statusCode,
      );
  }
}

String getErrorMessage(dynamic res) {
  String message = "";
  try {
    debugPrint("-------------------GET ERROR ------------------");
    if (res["message"] is List) {
      final List<dynamic> messages = res['message'][0]["messages"];
      messages.forEach((dynamic element) {
        message += (element as Map<String, dynamic>)['message'] + '\n';
      });
    } else if (res["message"] is String) {
      message = res["message"];
    } else if (res["error"] is Map) {
      if (res["error"]["message"] is String) {
        message = res["error"]["message"];
      }
    }
  } catch (e) {
    return message;
  }
  return message;
}
