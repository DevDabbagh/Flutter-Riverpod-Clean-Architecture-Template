import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants.dart';

part 'dio_helper.g.dart';

@riverpod
Dio dioHelper(DioHelperRef ref) {
  final dio = Dio();

  dio.options.baseUrl = ApiEndPoints.baseUrl;
  dio.options.connectTimeout = Constants.connectionTimeout;
  dio.options.receiveTimeout = const Duration(
    milliseconds: Constants.receiveTimeout,
  );
  dio.options.responseType = ResponseType.json;

  // SSL Bypass (Dev only)
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'PLATFORM_NAME': Platform.isAndroid ? 'android' : 'ios',
  };

  // Interceptors
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get token from SharedPreferences (using basic impl for now)
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString(Constants.USER_AUTH_TOKEN);

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onError: (DioException error, handler) {
        // You can trigger DioExceptions here if you want global handling
        // DioExceptions.fromDioError(error);
        return handler.next(error);
      },
    ),
  );

  // Logger
  dio.interceptors.add(
    HttpFormatter(
      includeRequest: true,
      includeResponseBody: true,
      loggingFilter: (request, response, error) {
        if (request == null) return false;
        return request.method != 'OPTIONS';
      },
    ),
  );

  return dio;
}

// Helper for Multipart
Future<FormData> addFormDataToJson({
  required Map<String, dynamic> jsonObject,
  String? jsonKey,
  String? filePath,
  String? fileName,
}) async {
  if (jsonKey != null && filePath != null) {
    jsonObject[jsonKey] = await MultipartFile.fromFile(
      filePath,
      filename: fileName,
    );
  }
  return FormData.fromMap(jsonObject);
}
