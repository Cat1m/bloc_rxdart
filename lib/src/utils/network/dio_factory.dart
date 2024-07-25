import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioFactory {
  static Future<Dio> getDio({String? baseUrl}) async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl ?? 'https://jsonplaceholder.typicode.com',
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }

    return dio;
  }
}
