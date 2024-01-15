import 'package:flutter/material.dart';

import '../../common/components/paginated_list_view.dart';
import '../../common/models/app_exception_messages.dart';
import '../../common/models/pagination.dart';
import 'models/quote.dart';
import 'quotes_view.dart';
import 'use_cases/get_quotes_use_case.dart';

class QuotesViewModel with ChangeNotifier implements PaginationManager {
  final _quotes = <Quote>[];
  var _isLoading = false;
  AppExceptionMessages? _errorMessage;
  var _pagination = Pagination.initial();
  var _quotesState = QuotesState.initial;

  final GetQuotesUseCase getQuotesUseCase;

  QuotesViewModel({required this.getQuotesUseCase});

  @override
  int get currentPage => _pagination.currentPage;

  @override
  bool get hasNextPage => _pagination.hasNextPage;

  List<Quote> get quotes => _quotes;

  AppExceptionMessages? get errorMessage => _errorMessage;

  QuotesState get state => _quotesState;

  Future<void> loadQuotes() async {
    _quotes.clear();
    _setQuotesState(QuotesState.loading);
    await _getQuotes(_pagination.nextPage);
  }

  @override
  Future<void> loadMoreContent(int page) async {
    if (_isLoading) return;

    _isLoading = true;
    await _getQuotes(page);
    _isLoading = false;
  }

  Future<void> _getQuotes(int page) async {
    final getQuotesResult = await getQuotesUseCase(page: page);

    getQuotesResult.fold(
      success: (paginationWithQuotes) {
        _pagination = paginationWithQuotes.pagination;
        _quotes.addAll(paginationWithQuotes.quotes);
        _setQuotesState(QuotesState.success);
      },
      failure: (errorMessage) {
        _errorMessage = errorMessage;
        _setQuotesState(QuotesState.failure);
      },
    );
  }

  void _setQuotesState(QuotesState newState) {
    _quotesState = newState;
    notifyListeners();
  }
}
