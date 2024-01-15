import 'dart:async';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/foundation.dart';

import '../../utils/either.dart';
import '../services/internet_check_service.dart';
import 'endpoint.dart';
import 'http_exception.dart';
import 'interceptors/custom_cache_interceptor.dart';
import 'server_host.dart';

typedef HttpResult = FutureOr<Either<HttpException, Object>>;

abstract interface class HttpClient {
  HttpResult get({required Endpoint endpoint});
}

class DioHttpClient implements HttpClient {
  late Dio _dio;

  final InternetCheckService internetCheckService;

  DioHttpClient({
    required this.internetCheckService,
    required Directory appTemporaryDirectory,
  }) {
    final baseOptions = BaseOptions(
      baseUrl: ServerHost.baseUrl,
    );

    _dio = Dio(baseOptions);

    if (kDebugMode) {
      _dio.interceptors.add(ChuckerDioInterceptor());
    }

    final cacheStore = FileCacheStore(appTemporaryDirectory.path);
    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.refreshForceCache,
    );

    _dio.interceptors.add(CustomCacheInterceptor(
      cacheStore: cacheStore,
      internetCheckService: internetCheckService,
    ));
    _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  @override
  HttpResult get({required Endpoint endpoint}) async {
    final requestOptions = Options(headers: ServerHost.headers);

    try {
      final response = await _dio.get(
        endpoint.path,
        options: requestOptions,
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
