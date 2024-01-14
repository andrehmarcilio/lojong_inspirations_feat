import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/features/videos/use_cases/get_videos_use_case.dart';
import 'package:lojong_test_app/features/videos/videos_view_model.dart';
import 'package:lojong_test_app/features/videos/videos_view_states.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class GetVideosUseCaseMock extends Mock implements GetVideosUseCase {}

void main() {
  group('VideosViewModel |', () {
    late GetVideosUseCaseMock getVideosUseCase;
    late VideosViewModel videosViewModel;

    setUp(() {
      getVideosUseCase = GetVideosUseCaseMock();
      videosViewModel = VideosViewModel(getVideosUseCase: getVideosUseCase);
    });
    test(
        'should update state to VideosLoading and to VideosSuccess '
        'when invoked loadVideos and getVideosUseCase return success', () async {
      final states = [];
      videosViewModel.state.addListener(() {
        states.add(videosViewModel.state.value);
      });
      when(() => getVideosUseCase()).thenAnswer((_) => Success([]));

      await videosViewModel.loadVideos();

      expect(states[0], isA<VideosLoading>());
      expect(states[1], isA<VideosSuccess>());
    });

    test(
        'should update state to VideosLoading and to VideosFailure '
        'when invoked loadVideos and getVideosUseCase return failure', () async {
      final states = [];
      videosViewModel.state.addListener(() {
        states.add(videosViewModel.state.value);
      });
      when(() => getVideosUseCase()).thenAnswer((_) => Failure(AppExceptionMessages.unknown));

      await videosViewModel.loadVideos();

      expect(states[0], isA<VideosLoading>());
      expect(states[1], isA<VideosFailure>());
    });
  });
}
