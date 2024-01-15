import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/data/remote/interceptors/custom_cache_interceptor.dart';
import 'package:lojong_test_app/data/services/internet_check_service.dart';
import 'package:mocktail/mocktail.dart';

class FileCacheStoreMock extends Mock implements FileCacheStore {}

class InternetCheckServiceMock extends Mock implements InternetCheckService {}

class RequestInterceptorHandlerMock extends Mock implements RequestInterceptorHandler {}

class ResponseMock extends Mock implements Response {}

class CacheResponseMock extends Mock implements CacheResponse {
  @override
  late DateTime responseDate;

  CacheResponseMock();

  @override
  Response toResponse(RequestOptions options, {bool fromNetwork = false}) {
    return ResponseMock();
  }
}

void main() {
  group('CustomCacheInterceptor |', () {
    late FileCacheStoreMock fileCacheStore;
    late InternetCheckServiceMock internetCheckService;
    late CustomCacheInterceptor customCacheInterceptor;
    setUpAll(() {
      registerFallbackValue(CacheResponseMock());
      registerFallbackValue(ResponseMock());
      registerFallbackValue(RequestOptions());
      registerFallbackValue(DioException(requestOptions: RequestOptions()));
    });
    setUp(() {
      fileCacheStore = FileCacheStoreMock();
      internetCheckService = InternetCheckServiceMock();
      customCacheInterceptor = CustomCacheInterceptor(
        cacheStore: fileCacheStore,
        internetCheckService: internetCheckService,
      );
    });

    test('Should proceed with the request when no cached data and internet connection is available', () async {
      when(() => internetCheckService.hasInternetConnection).thenAnswer((_) async => true);
      when(() => fileCacheStore.get(any())).thenAnswer((_) async => null);

      final options = RequestOptions(path: '/videos');
      final handler = RequestInterceptorHandlerMock();

      await customCacheInterceptor.onRequest(options, handler);

      verify(() => handler.next(options)).called(1);
    });

    test('Should resolve with cached response when cache is present and not expired', () async {
      when(() => internetCheckService.hasInternetConnection).thenAnswer((_) async => true);
      when(() => fileCacheStore.get(any())).thenAnswer((_) async {
        return CacheResponseMock()..responseDate = DateTime.now().subtract(const Duration(hours: 4));
      });

      final options = RequestOptions(path: '/videos');
      final handler = RequestInterceptorHandlerMock();

      await customCacheInterceptor.onRequest(options, handler);

      verify(() => handler.resolve(any())).called(1);
    });

    test('Should resolve with cached response when cache was set within the last 7 days and has no internet connection',
        () async {
      when(() => internetCheckService.hasInternetConnection).thenAnswer((_) async => false);
      when(() => fileCacheStore.get(any())).thenAnswer((_) async {
        return CacheResponseMock()..responseDate = DateTime.now().subtract(const Duration(days: 5));
      });

      final options = RequestOptions(path: '/videos');
      final handler = RequestInterceptorHandlerMock();

      await customCacheInterceptor.onRequest(options, handler);

      verify(() => handler.resolve(any())).called(1);
    });

    test('Should proceed with the request when cache was set more than 1 day ago and has internet connection',
        () async {
      when(() => internetCheckService.hasInternetConnection).thenAnswer((_) async => true);
      when(() => fileCacheStore.get(any())).thenAnswer((_) async {
        return CacheResponseMock()..responseDate = DateTime.now().subtract(const Duration(days: 1));
      });

      final options = RequestOptions(path: '/videos');
      final handler = RequestInterceptorHandlerMock();

      await customCacheInterceptor.onRequest(options, handler);

      verify(() => handler.next(any())).called(1);
    });

    test('Should reject the request when cache is expired and internet connection is not available', () async {
      when(() => internetCheckService.hasInternetConnection).thenAnswer((_) async => false);
      when(() => fileCacheStore.get(any())).thenAnswer((_) async {
        return CacheResponseMock()..responseDate = DateTime.now().subtract(const Duration(days: 8));
      });

      final options = RequestOptions(path: '/videos');
      final handler = RequestInterceptorHandlerMock();

      await customCacheInterceptor.onRequest(options, handler);

      verify(() => handler.reject(any())).called(1);
    });
  });
}
