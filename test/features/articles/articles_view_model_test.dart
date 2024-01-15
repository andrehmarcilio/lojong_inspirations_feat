import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/common/models/pagination.dart';
import 'package:lojong_test_app/features/articles/articles_view.dart';
import 'package:lojong_test_app/features/articles/articles_view_model.dart';
import 'package:lojong_test_app/features/articles/models/pagination_with_articles.dart';
import 'package:lojong_test_app/features/articles/use_cases/get_articles_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class GetArticlesUseCaseMock extends Mock implements GetArticlesUseCase {}

void main() {
  group('ArticlesViewModel |', () {
    late GetArticlesUseCaseMock getArticlesUseCase;
    late ArticlesViewModel articlesViewModel;

    setUp(() {
      getArticlesUseCase = GetArticlesUseCaseMock();
      articlesViewModel = ArticlesViewModel(getArticlesUseCase: getArticlesUseCase);
    });
    test(
        'should update state to ArticlesLoading and to ArticlesSuccess '
        'when invoked loadArticles and getArticlesUseCase return success', () async {
      final states = [];
      articlesViewModel.addListener(() {
        states.add(articlesViewModel.state);
      });
      when(() => getArticlesUseCase(page: 1)).thenAnswer((_) {
        return Success(PaginationWithArticles(
          pagination: Pagination.initial(),
          articles: [],
        ));
      });

      await articlesViewModel.loadArticles();

      expect(states[0], ArticlesState.loading);
      expect(states[1], ArticlesState.success);
    });

    test(
        'should update state to ArticlesLoading and to ArticlesFailure '
        'when invoked loadArticles and getArticlesUseCase return failure', () async {
      final states = [];
      articlesViewModel.addListener(() {
        states.add(articlesViewModel.state);
      });
      when(() => getArticlesUseCase(page: 1)).thenAnswer((_) => Failure(AppExceptionMessages.unknown));

      await articlesViewModel.loadArticles();

      expect(states[0], ArticlesState.loading);
      expect(states[1], ArticlesState.failure);
    });
  });
}
