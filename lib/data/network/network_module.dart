import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../preference/app_pref.dart';
import 'clients/api_client.dart';
import 'clients/auth_client.dart';
import 'petty_dio_logger.dart';

// live
// const String baseURL = 'http://54.197.87.12/api/v1/';
const String baseURL = 'http://52.91.98.41/api/v1/';

abstract class NetworkModule {
  static Dio prepareDio() {
    final dio = Dio();

    //dio.interceptors.add(AuthInterceptor(dio));

    final appPref = Get.find<AppPref>();

    const inDebugMode = kDebugMode;
    var isTokenPrinted = false;

    dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) async {
      final customHeaders = {
        'Accept': 'application/json',
      };

      final authToken = appPref.authToken;
      if (authToken.isNotEmpty) {
        customHeaders['Authorization'] = 'Bearer $authToken';
      }

      if (inDebugMode && authToken.isNotEmpty && !isTokenPrinted) {
        log('AuthToken: $authToken');
        isTokenPrinted = true;
      }
      option.headers.addAll(customHeaders);
      handler.next(option);
    }));

    /// PreDioLogger to print api log in DEBUG mode
    if (!kReleaseMode) {
      final logger = PrettyDioLogger(maxWidth: 200);
      dio.interceptors.add(logger);
    }
    return dio;
  }

  static ApiClient getApiClient() => ApiClient(Get.find<Dio>(), baseUrl: baseURL);

  static AuthClient getAuthClient() => AuthClient(Get.find<Dio>(), baseUrl: baseURL);
}
