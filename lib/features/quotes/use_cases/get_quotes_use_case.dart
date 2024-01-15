import 'dart:async';

import '../../../common/adapters/pagination_adapter.dart';
import '../../../common/models/app_exception_messages.dart';
import '../../../data/services/quote_service.dart';
import '../../../utils/either.dart';
import '../adapters/quote_adapter.dart';
import '../models/pagination_with_quotes.dart';

abstract interface class GetQuotesUseCase {
  FutureOr<Either<AppExceptionMessages, PaginationWithQuotes>> call({required int page});
}

class GetQuotesUseCaseImpl implements GetQuotesUseCase {
  final QuoteService quoteService;

  GetQuotesUseCaseImpl({required this.quoteService});

  @override
  FutureOr<Either<AppExceptionMessages, PaginationWithQuotes>> call({required int page}) async {
    final result = await quoteService.getQuotes(page: page);

    if (result.isSuccess) {
      final quotes = QuoteAdapter.fromList(result.successData['list']);
      final pagination = PaginationAdapter.fromMap(result.successData);

      return Success(PaginationWithQuotes(pagination: pagination, quotes: quotes));
    }

    return Failure(result.failureData);
  }
}
