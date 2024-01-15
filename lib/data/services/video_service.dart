import 'dart:async';

import '../../common/models/app_exception_messages.dart';
import '../../utils/either.dart';
import '../remote/endpoint.dart';
import '../remote/http_client.dart';

abstract interface class VideoService {
  FutureOr<Either<AppExceptionMessages, dynamic>> getVideos();
}

class VideoServiceImpl implements VideoService {
  final HttpClient client;

  VideoServiceImpl({required this.client});

  @override
  FutureOr<Either<AppExceptionMessages, dynamic>> getVideos() async {
    final endpoint = Endpoint(path: '/videos');

    final requestResult = await client.get(endpoint: endpoint);

    if (requestResult.isSuccess) {
      return Success(requestResult.successData);
    }

    return Failure(requestResult.failureData.exceptionMessage);
  }
}
