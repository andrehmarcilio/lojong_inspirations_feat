import 'package:flutter/material.dart';

import '../../common/components/paginated_list_view.dart';
import '../../common/models/app_exception_messages.dart';
import '../../common/models/pagination.dart';
import 'articles_view.dart';
import 'models/article.dart';
import 'use_cases/get_articles_use_case.dart';

class ArticlesViewModel with ChangeNotifier implements PaginationManager {
  final _articles = <Article>[];
  var _isLoading = false;
  AppExceptionMessages? _errorMessage;
  var _pagination = Pagination.initial();
  var _articlesState = ArticlesState.initial;

  final GetArticlesUseCase getArticlesUseCase;

  ArticlesViewModel({required this.getArticlesUseCase});

  @override
  int get currentPage => _pagination.currentPage;

  @override
  bool get hasNextPage => _pagination.hasNextPage;

  List<Article> get articles => _articles;

  AppExceptionMessages? get errorMessage => _errorMessage;

  ArticlesState get state => _articlesState;

  Future<void> loadArticles() async {
    _articles.clear();
    _setArticlesState(ArticlesState.loading);
    await _getArticles(_pagination.nextPage);
  }

  @override
  Future<void> loadMoreContent(int page) async {
    if (_isLoading) return;

    _isLoading = true;
    await _getArticles(page);
    _isLoading = false;
  }

  Future<void> _getArticles(int page) async {
    final getArticlesResult = await getArticlesUseCase(page: page);

    getArticlesResult.fold(
      success: (paginationWithArticles) {
        _pagination = paginationWithArticles.pagination;
        _articles.addAll(paginationWithArticles.articles);
        _setArticlesState(ArticlesState.success);
      },
      failure: (errorMessage) {
        _errorMessage = errorMessage;
        _setArticlesState(ArticlesState.failure);
      },
    );
  }

  void _setArticlesState(ArticlesState newState) {
    _articlesState = newState;
    notifyListeners();
  }
}
