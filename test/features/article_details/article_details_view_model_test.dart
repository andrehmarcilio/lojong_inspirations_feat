import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/features/article_details/article_details_state.dart';
import 'package:lojong_test_app/features/article_details/article_details_view_model.dart';
import 'package:lojong_test_app/features/article_details/models/article_details.dart';
import 'package:lojong_test_app/features/article_details/use_cases/get_article_details_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class GetArticleDetailsUseCaseMock extends Mock implements GetArticleDetailsUseCase {}

void main() {
  group('ArticleDetailsViewModel |', () {
    late GetArticleDetailsUseCaseMock getArticleDetailsUseCase;
    late ArticleDetailsViewModel articleDetailsViewModel;

    setUp(() {
      getArticleDetailsUseCase = GetArticleDetailsUseCaseMock();
      articleDetailsViewModel = ArticleDetailsViewModel(
        articleId: 1,
        getArticleDetailsUseCase: getArticleDetailsUseCase,
      );
    });
    test(
        'should update state to ArticleDetailsLoading and to ArticleDetailsSuccess '
        'when invoked loadArticleDetails and getArticleDetailsUseCase return success', () async {
      final states = [];
      articleDetailsViewModel.state.addListener(() {
        states.add(articleDetailsViewModel.state.value);
      });
      when(() => getArticleDetailsUseCase(articleId: 1)).thenAnswer((_) {
        return Success(_mockedArticleDetails);
      });

      await articleDetailsViewModel.loadArticleDetails();

      expect(states[0], isA<ArticleDetailsLoading>());
      expect(states[1], isA<ArticleDetailsSuccess>());
    });

    test(
        'should update state to ArticleDetailsLoading and to ArticleDetailsFailure '
        'when invoked loadArticleDetails and getArticleDetailsUseCase return failure', () async {
      final states = [];
      articleDetailsViewModel.state.addListener(() {
        states.add(articleDetailsViewModel.state.value);
      });
      when(() => getArticleDetailsUseCase(articleId: 1)).thenAnswer((_) => Failure(AppExceptionMessages.unknown));

      await articleDetailsViewModel.loadArticleDetails();

      expect(states[0], isA<ArticleDetailsLoading>());
      expect(states[1], isA<ArticleDetailsFailure>());
    });
  });
}

final _mockedArticleDetails = ArticleDetails(
  id: 1,
  text: 'text',
  title: 'title',
  imageUrl: 'imageUrl',
  authorName: 'authorName',
  authorDescription: 'authorDescription',
  htmlContent: 'htmlContent',
);
