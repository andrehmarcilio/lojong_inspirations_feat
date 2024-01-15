import 'package:flutter/material.dart';

import 'use_cases/get_videos_use_case.dart';
import 'videos_view_states.dart';

class VideosViewModel {
  final _videosState = ValueNotifier<VideosState>(VideosInitial());

  final GetVideosUseCase getVideosUseCase;

  VideosViewModel({required this.getVideosUseCase});

  ValueNotifier<VideosState> get state => _videosState;

  Future<void> loadVideos() async {
    _videosState.value = VideosLoading();

    final getVideosResult = await getVideosUseCase();

    getVideosResult.fold(
      success: (videos) {
        _videosState.value = VideosSuccess(videos: videos);
      },
      failure: (errorMessage) {
        _videosState.value = VideosFailure(errorMessage: errorMessage);
      },
    );
  }
}
