import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/data/remote/endpoint.dart';
import 'package:lojong_test_app/data/remote/http_client.dart';
import 'package:lojong_test_app/data/remote/http_exception.dart';
import 'package:lojong_test_app/data/services/article_service.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {}

class MockedEndpoint extends Mock implements Endpoint {}

void main() {
  group('Article Service |', () {
    late HttpClientMock httpClient;
    late ArticleService articleService;
    setUp(() {
      httpClient = HttpClientMock();
      articleService = ArticleServiceImpl(client: httpClient);

      registerFallbackValue(MockedEndpoint());
    });

    test('getArticles should return a success result when httpClient return a success response', () async {
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Success({}));

      final result = await articleService.getArticles(page: 1);

      expect(result.isSuccess, isTrue);
    });

    test('getArticles should return the response data when httpClient return a success response', () async {
      final mockedResponseData = [
        {'title': 'O relato de um retiro de 10 dias de meditação'},
      ];
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Success(mockedResponseData));

      final result = await articleService.getArticles(page: 1);

      expect(result.successData, mockedResponseData);
    });

    test('getArticles should return a serverSide exception message when httpClient return a 500 status code', () async {
      final serverSideException = HttpException(statusCode: 500);
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Failure(serverSideException));

      final result = await articleService.getArticles(page: 1);

      expect(result.failureData, equals(AppExceptionMessages.serverSide));
    });

    test('getArticles should return a unknown exception message when httpClient return a 500 status code', () async {
      final unknownException = HttpException();
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Failure(unknownException));

      final result = await articleService.getArticles(page: 1);

      expect(result.failureData, equals(AppExceptionMessages.unknown));
    });

    test('getArticleDetails should return the response data when httpClient return a success response', () async {
      final mockedResponseData = [
        {'title': 'O relato de um retiro de 10 dias de meditação'},
      ];
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Success(mockedResponseData));

      final result = await articleService.getArticleDetails(articleId: 1);

      expect(result.successData, mockedResponseData);
    });

    test('getArticles should return a serverSide exception message when httpClient return a 500 status code', () async {
      final serverSideException = HttpException(statusCode: 500);
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Failure(serverSideException));

      final result = await articleService.getArticleDetails(articleId: 1);

      expect(result.failureData, equals(AppExceptionMessages.serverSide));
    });
  });
}
