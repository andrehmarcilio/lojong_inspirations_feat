import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/common/placeholders/error_placeholder.dart';
import 'package:lojong_test_app/features/videos/models/video.dart';
import 'package:lojong_test_app/features/videos/use_cases/get_videos_use_case.dart';
import 'package:lojong_test_app/features/videos/videos_view.dart';
import 'package:lojong_test_app/features/videos/videos_view_model.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:lojong_test_app/utils/service_locator/service_locator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../app/lojong_app_mock.dart';

class GetVideosUseCaseMock extends Mock implements GetVideosUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('VideosView |', () {
    late GetVideosUseCaseMock getVideosUseCase;

    setUp(() {
      getVideosUseCase = GetVideosUseCaseMock();
      serviceLocator.registerFactory(() => VideosViewModel(getVideosUseCase: getVideosUseCase));
    });

    tearDown(() {
      serviceLocator.reset();
    });
    testWidgets('the videos name and description should be visible when usecase returns success', (tester) async {
      when(() => getVideosUseCase()).thenAnswer((_) => Success(_videos));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const LojongAppMock(home: VideosView()));
        await tester.pumpAndSettle();

        for (final video in _videos) {
          await tester.scrollUntilVisible(find.text(video.name), 50);
          expect(find.text(video.name, skipOffstage: false), findsAtLeastNWidgets(1));
          expect(find.text(video.description, skipOffstage: false), findsAtLeastNWidgets(1));
        }
      });
    });

    testWidgets('should show a error message when usecase returns failure', (tester) async {
      when(() => getVideosUseCase()).thenAnswer((_) => Failure(AppExceptionMessages.unknown));

      await tester.pumpWidget(const LojongAppMock(home: VideosView()));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorPlaceholder), findsOne);
    });
  });
}

final _videos = [
  Video(
    id: 1,
    name: 'O que é mindfulness?',
    imageUrl: 'https://example.com/mindfulness_video1_thumbnail.jpg',
    description: 'Mindfulness é a prática de estar consciente e presente no momento, '
        'sem julgamentos. Descubra mais sobre essa técnica de meditação.',
  ),
  Video(
    id: 2,
    name: 'Técnicas de Respiração',
    imageUrl: 'https://example.com/mindfulness_video2_thumbnail.jpg',
    description: 'Explore diferentes técnicas de respiração para acalmar a mente e '
        'melhorar a concentração durante a meditação.',
  ),
  Video(
    id: 3,
    name: 'Meditação Guiada para Iniciantes',
    imageUrl: 'https://example.com/mindfulness_video3_thumbnail.jpg',
    description: 'Esta meditação guiada é perfeita para iniciantes que desejam '
        'começar sua jornada de mindfulness. Siga as instruções e relaxe.',
  ),
];
