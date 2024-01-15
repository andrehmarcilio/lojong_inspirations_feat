import 'dart:async';

import '../../common/models/app_exception_messages.dart';
import '../../utils/either.dart';
import '../remote/endpoint.dart';
import '../remote/http_client.dart';

abstract interface class QuoteService {
  FutureOr<Either<AppExceptionMessages, dynamic>> getQuotes({required int page});
}

class QuoteServiceImpl implements QuoteService {
  final HttpClient client;

  QuoteServiceImpl({required this.client});

  @override
  FutureOr<Either<AppExceptionMessages, dynamic>> getQuotes({required int page}) async {
    final endpoint = Endpoint(path: '/quotes2', queryParameters: {'page': page});

    final requestResult = await client.get(endpoint: endpoint);

    if (requestResult.isSuccess) {
      return Success(requestResult.successData);
    }

    return Failure(requestResult.failureData.exceptionMessage);
  }
}
