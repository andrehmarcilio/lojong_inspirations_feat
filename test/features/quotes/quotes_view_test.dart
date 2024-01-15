import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/common/models/pagination.dart';
import 'package:lojong_test_app/common/placeholders/error_placeholder.dart';
import 'package:lojong_test_app/features/quotes/models/pagination_with_quotes.dart';
import 'package:lojong_test_app/features/quotes/models/quote.dart';
import 'package:lojong_test_app/features/quotes/quotes_view.dart';
import 'package:lojong_test_app/features/quotes/quotes_view_model.dart';
import 'package:lojong_test_app/features/quotes/use_cases/get_quotes_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:lojong_test_app/utils/service_locator/service_locator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../app/lojong_app_mock.dart';

class GetQuotesUseCaseMock extends Mock implements GetQuotesUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('QuotesView |', () {
    late GetQuotesUseCaseMock getQuotesUseCase;

    setUp(() {
      getQuotesUseCase = GetQuotesUseCaseMock();
      serviceLocator.registerFactory(() => QuotesViewModel(getQuotesUseCase: getQuotesUseCase));
    });

    tearDown(() {
      serviceLocator.reset();
    });
    testWidgets('the quotes author and text should be visible when usecase returns success', (tester) async {
      when(() => getQuotesUseCase(page: 1)).thenAnswer((_) {
        return Success(PaginationWithQuotes(
          pagination: Pagination(currentPage: 1, hasNextPage: false),
          quotes: _quotes,
        ));
      });

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const LojongAppMock(home: QuotesView()));
        await tester.pumpAndSettle();

        for (final article in _quotes) {
          await tester.scrollUntilVisible(find.text(article.author), 50);
          expect(find.text(article.author, skipOffstage: false), findsAtLeastNWidgets(1));
          expect(find.text(article.text, skipOffstage: false), findsAtLeastNWidgets(1));
        }
      });
    });

    testWidgets('should show a error message when usecase returns failure', (tester) async {
      when(() => getQuotesUseCase(page: 1)).thenAnswer((_) => Failure(AppExceptionMessages.unknown));

      await tester.pumpWidget(const LojongAppMock(home: QuotesView()));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorPlaceholder), findsOne);
    });
  });
}

final _quotes = [
  Quote(
    id: 1,
    author: 'O que é mindfulness?',
    text: 'Mindfulness é a prática de estar consciente e presente no momento, '
        'sem julgamentos. Descubra mais sobre essa técnica de meditação.',
  ),
  Quote(
    id: 2,
    author: 'Técnicas de Respiração',
    text: 'Explore diferentes técnicas de respiração para acalmar a mente e '
        'melhorar a concentração durante a meditação.',
  ),
  Quote(
    id: 3,
    author: 'Meditação Guiada para Iniciantes',
    text: 'Esta meditação guiada é perfeita para iniciantes que desejam '
        'começar sua jornada de mindfulness. Siga as instruções e relaxe.',
  ),
];
