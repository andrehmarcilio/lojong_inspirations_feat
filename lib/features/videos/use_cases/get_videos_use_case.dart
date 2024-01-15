import 'dart:async';

import '../../../common/models/app_exception_messages.dart';
import '../../../data/services/video_service.dart';
import '../../../utils/either.dart';
import '../adapters/video_adapter.dart';
import '../models/video.dart';

abstract interface class GetVideosUseCase {
  FutureOr<Either<AppExceptionMessages, List<Video>>> call();
}

class GetVideosUseCaseImpl implements GetVideosUseCase {
  final VideoService videoService;

  GetVideosUseCaseImpl({required this.videoService});

  @override
  FutureOr<Either<AppExceptionMessages, List<Video>>> call() async {
    final result = await videoService.getVideos();

    if (result.isSuccess) {
      final videos = VideoAdapter.fromList(result.successData);
      return Success(videos);
    }

    return Failure(result.failureData);
  }
}
