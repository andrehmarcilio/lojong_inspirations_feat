import 'dart:async';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../utils/either.dart';
import 'endpoint.dart';
import 'http_exception.dart';
import 'server_host.dart';

typedef HttpResult = FutureOr<Either<HttpException, Object>>;

abstract interface class HttpClient {
  FutureOr<HttpResult> get({required Endpoint endpoint});
}

class DioHttpClient implements HttpClient {
  late Dio _dio;

  DioHttpClient() {
    final baseOptions = BaseOptions(
      baseUrl: ServerHost.baseUrl,
    );

    _dio = Dio(baseOptions);

    if (kDebugMode) {
      _dio.interceptors.add(ChuckerDioInterceptor());
    }
  }

  @override
  FutureOr<HttpResult> get({required Endpoint endpoint}) async {
    try {
      final response = await _dio.get(
        endpoint.path,
        queryParameters: endpoint.queryParameters,
      );
      return Success(response.data);
    } on DioException catch (e) {
      return Failure(HttpException(
        message: e.message,
        statusCode: e.response?.statusCode,
      ));
    }
  }
}
