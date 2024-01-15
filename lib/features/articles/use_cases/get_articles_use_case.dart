import 'dart:async';

import '../../../common/adapters/pagination_adapter.dart';
import '../../../common/models/app_exception_messages.dart';
import '../../../data/services/article_service.dart';
import '../../../utils/either.dart';
import '../adapters/article_adapter.dart';
import '../models/pagination_with_articles.dart';

abstract interface class GetArticlesUseCase {
  FutureOr<Either<AppExceptionMessages, PaginationWithArticles>> call({required int page});
}

class GetArticlesUseCaseImpl implements GetArticlesUseCase {
  final ArticleService articleService;

  GetArticlesUseCaseImpl({required this.articleService});

  @override
  FutureOr<Either<AppExceptionMessages, PaginationWithArticles>> call({required int page}) async {
    final result = await articleService.getArticles(page: page);

    if (result.isSuccess) {
      final articles = ArticleAdapter.fromList(result.successData['list']);
      final pagination = PaginationAdapter.fromMap(result.successData);

      return Success(PaginationWithArticles(pagination: pagination, articles: articles));
    }

    return Failure(result.failureData);
  }
}
