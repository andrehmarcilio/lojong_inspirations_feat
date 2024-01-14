import '../../common/models/app_exception_messages.dart';
import 'models/video.dart';

sealed class VideosState {}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosSuccess extends VideosState {
  final List<Video> videos;

  VideosSuccess({required this.videos});
}

class VideosFailure extends VideosState {
  final AppExceptionMessages errorMessage;

  VideosFailure({required this.errorMessage});
}
