import 'package:flutter/material.dart';

import 'article_details_state.dart';
import 'use_cases/get_article_details_use_case.dart';

class ArticleDetailsViewModel {
  final _articleDetailsState = ValueNotifier<ArticleDetailsState>(ArticleDetailsInitial());

  final int articleId;
  final GetArticleDetailsUseCase getArticleDetailsUseCase;

  ArticleDetailsViewModel({
    required this.articleId,
    required this.getArticleDetailsUseCase,
  });

  ValueNotifier<ArticleDetailsState> get state => _articleDetailsState;

  Future<void> loadArticleDetails() async {
    _articleDetailsState.value = ArticleDetailsLoading();

    final getArticleDetailsResult = await getArticleDetailsUseCase(articleId: articleId);

    getArticleDetailsResult.fold(
      success: (articleDetails) {
        _articleDetailsState.value = ArticleDetailsSuccess(article: articleDetails);
      },
      failure: (errorMessage) {
        _articleDetailsState.value = ArticleDetailsFailure(errorMessage: errorMessage);
      },
    );
  }
}
