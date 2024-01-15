import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/data/remote/endpoint.dart';
import 'package:lojong_test_app/data/remote/http_client.dart';
import 'package:lojong_test_app/data/remote/http_exception.dart';
import 'package:lojong_test_app/data/services/quote_service.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {}

class MockedEndpoint extends Mock implements Endpoint {}

void main() {
  group('Quote Service |', () {
    late HttpClientMock httpClient;
    late QuoteService quoteService;
    setUp(() {
      httpClient = HttpClientMock();
      quoteService = QuoteServiceImpl(client: httpClient);

      registerFallbackValue(MockedEndpoint());
    });

    test('getQuotes should return a success result when httpClient return a success response', () async {
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Success({}));

      final result = await quoteService.getQuotes(page: 1);

      expect(result.isSuccess, isTrue);
    });

    test('getQuotes should return the response data when httpClient return a success response', () async {
      final mockedResponseData = [
        {'text': '"Por que você precisa meditar? Porque se você não praticar...."'},
      ];
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Success(mockedResponseData));

      final result = await quoteService.getQuotes(page: 1);

      expect(result.successData, mockedResponseData);
    });

    test('getQuotes should return a serverSide exception message when httpClient return a 500 status code', () async {
      final serverSideException = HttpException(statusCode: 500);
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Failure(serverSideException));

      final result = await quoteService.getQuotes(page: 1);

      expect(result.failureData, equals(AppExceptionMessages.serverSide));
    });

    test('getQuotes should return a unknown exception message when httpClient return a 500 status code', () async {
      final unknownException = HttpException();
      when(() => httpClient.get(endpoint: any(named: 'endpoint'))).thenAnswer((_) => Failure(unknownException));

      final result = await quoteService.getQuotes(page: 1);

      expect(result.failureData, equals(AppExceptionMessages.unknown));
    });
  });
}
