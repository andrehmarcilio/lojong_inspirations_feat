import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';

import '../../../utils/extensions/date_time_extensions.dart';
import '../../services/internet_check_service.dart';

class CustomCacheInterceptor extends QueuedInterceptor {
  final FileCacheStore cacheStore;
  final InternetCheckService internetCheckService;

  CustomCacheInterceptor({
    required this.cacheStore,
    required this.internetCheckService,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final key = CacheOptions.defaultCacheKeyBuilder(options);
    final cache = await cacheStore.get(key);

    if (cache != null && cache.responseDate.daysPassed < 1) {
      return handler.resolve(cache.toResponse(options));
    }

    final hasNotConnection = !await internetCheckService.hasInternetConnection;

    void reject() {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          response: Response(requestOptions: options),
        ),
      );
    }

    if (cache == null) {
      if (hasNotConnection) return reject();

      return handler.next(options);
    }

    if (hasNotConnection) {
      if (cache.responseDate.daysPassed <= 7) {
        return handler.resolve(cache.toResponse(options));
      }

      return reject();
    }

    return handler.next(options);
  }
}
