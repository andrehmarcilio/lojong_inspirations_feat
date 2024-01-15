import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/data/remote/endpoint.dart';
import 'package:lojong_test_app/data/remote/http_client.dart';
import 'package:lojong_test_app/data/remote/http_exception.dart';
import 'package:lojong_test_app/data/services/video_service.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {}

class MockedEndpoint extends Mock implements Endpoint {}

void main() {
  group('Video Service |', () {
    late HttpClientMock httpClient;
    late VideoService videoService;
    setUp(() {
      httpClient = HttpClientMock();
      videoService = VideoServiceImpl(client: httpClient);

      registerFallbackValue(MockedEndpoint());
    });

    test('getVideos should return a success result when httpClient return a success response', () async {
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Success({}));

      final result = await videoService.getVideos();

      expect(result.isSuccess, isTrue);
    });

    test('getVideos should return the response data when httpClient return a success response', () async {
      final mockedResponseData = [
        {'name': 'Meditação Guiada para Iniciantes'},
      ];
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Success(mockedResponseData));

      final result = await videoService.getVideos();

      expect(result.successData, mockedResponseData);
    });

    test('getVideos should return a serverSide exception message when httpClient return a 500 status code', () async {
      final serverSideException = HttpException(statusCode: 500);
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Failure(serverSideException));

      final result = await videoService.getVideos();

      expect(result.failureData, equals(AppExceptionMessages.serverSide));
    });

    test('getVideos should return a unknown exception message when httpClient return a null status code', () async {
      final noConnectionException = HttpException();
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Failure(noConnectionException));

      final result = await videoService.getVideos();

      expect(result.failureData, equals(AppExceptionMessages.noConnection));
    });
  });
}
