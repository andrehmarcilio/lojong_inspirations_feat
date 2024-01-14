import 'dart:async';

import '../../common/models/app_exception_messages.dart';
import '../../utils/either.dart';
import '../remote/endpoint.dart';
import '../remote/http_client.dart';

abstract interface class ArticleService {
  FutureOr<Either<AppExceptionMessages, dynamic>> getArticles({required int page});
}

class ArticleServiceImpl implements ArticleService {
  final HttpClient client;

  ArticleServiceImpl({required this.client});

  @override
  FutureOr<Either<AppExceptionMessages, dynamic>> getArticles({required int page}) async {
    final endpoint = Endpoint(path: '/articles2', queryParameters: {'page': page});

    final requestResult = await client.get(endpoint: endpoint);

    if (requestResult.isSuccess) {
      return Success(requestResult.successData);
    }

    return Failure(requestResult.failureData.exceptionMessage);
  }
}
