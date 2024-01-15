import 'dart:async';

import '../../../common/models/app_exception_messages.dart';
import '../../../data/services/article_service.dart';
import '../../../utils/either.dart';
import '../adapters/article_details_adapter.dart';
import '../models/article_details.dart';

abstract interface class GetArticleDetailsUseCase {
  FutureOr<Either<AppExceptionMessages, ArticleDetails>> call({required int articleId});
}

class GetArticleDetailsUseCaseImpl implements GetArticleDetailsUseCase {
  final ArticleService articleService;

  GetArticleDetailsUseCaseImpl({required this.articleService});

  @override
  FutureOr<Either<AppExceptionMessages, ArticleDetails>> call({required int articleId}) async {
    final result = await articleService.getArticleDetails(articleId: articleId);

    if (result.isSuccess) {
      final articleDetails = ArticleDetailsAdapter.fromMap(result.successData);

      return Success(articleDetails);
    }

    return Failure(result.failureData);
  }
}
