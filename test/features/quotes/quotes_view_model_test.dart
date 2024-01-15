import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/common/models/pagination.dart';
import 'package:lojong_test_app/features/quotes/models/pagination_with_quotes.dart';
import 'package:lojong_test_app/features/quotes/quotes_view.dart';
import 'package:lojong_test_app/features/quotes/quotes_view_model.dart';
import 'package:lojong_test_app/features/quotes/use_cases/get_quotes_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class GetQuotesUseCaseMock extends Mock implements GetQuotesUseCase {}

void main() {
  group('QuotesViewModel |', () {
    late GetQuotesUseCaseMock getQuotesUseCase;
    late QuotesViewModel quotesViewModel;

    setUp(() {
      getQuotesUseCase = GetQuotesUseCaseMock();
      quotesViewModel = QuotesViewModel(getQuotesUseCase: getQuotesUseCase);
    });
    test(
        'should update state to QuotesLoading and to QuotesSuccess '
        'when invoked loadQuotes and getQuotesUseCase return success', () async {
      final states = [];
      quotesViewModel.addListener(() {
        states.add(quotesViewModel.state);
      });
      when(() => getQuotesUseCase(page: 1)).thenAnswer((_) {
        return Success(PaginationWithQuotes(
          pagination: Pagination.initial(),
          quotes: [],
        ));
      });

      await quotesViewModel.loadQuotes();

      expect(states[0], QuotesState.loading);
      expect(states[1], QuotesState.success);
    });

    test(
        'should update state to QuotesLoading and to QuotesFailure '
        'when invoked loadQuotes and getQuotesUseCase return failure', () async {
      final states = [];
      quotesViewModel.addListener(() {
        states.add(quotesViewModel.state);
      });
      when(() => getQuotesUseCase(page: 1)).thenAnswer((_) => Failure(AppExceptionMessages.unknown));

      await quotesViewModel.loadQuotes();

      expect(states[0], QuotesState.loading);
      expect(states[1], QuotesState.failure);
    });
  });
}
