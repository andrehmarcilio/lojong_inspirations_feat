import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/common/models/pagination.dart';
import 'package:lojong_test_app/common/placeholders/error_placeholder.dart';
import 'package:lojong_test_app/features/article_details/article_details_view.dart';
import 'package:lojong_test_app/features/article_details/article_details_view_model.dart';
import 'package:lojong_test_app/features/article_details/models/article_details.dart';
import 'package:lojong_test_app/features/articles/articles_view.dart';
import 'package:lojong_test_app/features/articles/articles_view_model.dart';
import 'package:lojong_test_app/features/articles/components/article_item_widget.dart';
import 'package:lojong_test_app/features/articles/models/article.dart';
import 'package:lojong_test_app/features/articles/models/pagination_with_articles.dart';
import 'package:lojong_test_app/features/articles/use_cases/get_articles_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:lojong_test_app/utils/service_locator/service_locator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../app/lojong_app_mock.dart';
import '../article_details/article_details_view_model_test.dart';

class GetArticlesUseCaseMock extends Mock implements GetArticlesUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ArticlesView |', () {
    late GetArticlesUseCaseMock getArticlesUseCase;
    late GetArticleDetailsUseCaseMock getArticleDetailsUseCase;

    setUp(() {
      getArticlesUseCase = GetArticlesUseCaseMock();
      getArticleDetailsUseCase = GetArticleDetailsUseCaseMock();
      serviceLocator.registerFactory(() => ArticlesViewModel(getArticlesUseCase: getArticlesUseCase));
      serviceLocator.registerFactoryParam<ArticleDetailsViewModel, int>((id) {
        return ArticleDetailsViewModel(getArticleDetailsUseCase: getArticleDetailsUseCase, articleId: id);
      });
    });

    tearDown(() {
      serviceLocator.reset();
    });
    testWidgets('the articles title and text should be visible when usecase returns success', (tester) async {
      when(() => getArticlesUseCase(page: 1)).thenAnswer((_) {
        return Success(PaginationWithArticles(
          pagination: Pagination(currentPage: 1, hasNextPage: false),
          articles: _articles,
        ));
      });

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const LojongAppMock(home: ArticlesView()));
        await tester.pumpAndSettle();

        for (final article in _articles) {
          await tester.scrollUntilVisible(find.text(article.title), 50);
          expect(find.text(article.title, skipOffstage: false), findsAtLeastNWidgets(1));
          expect(find.text(article.text, skipOffstage: false), findsAtLeastNWidgets(1));
        }
      });
    });

    testWidgets('should show a error message when usecase returns failure', (tester) async {
      when(() => getArticlesUseCase(page: 1)).thenAnswer((_) => Failure(AppExceptionMessages.unknown));

      await tester.pumpWidget(const LojongAppMock(home: ArticlesView()));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorPlaceholder), findsOne);
    });

    testWidgets('should show article_details page when user taps an article', (tester) async {
      when(() => getArticlesUseCase(page: 1)).thenAnswer((_) {
        return Success(PaginationWithArticles(
          pagination: Pagination(currentPage: 1, hasNextPage: false),
          articles: _articles,
        ));
      });
      when(() => getArticleDetailsUseCase(articleId: any(named: 'articleId'))).thenAnswer((_) {
        return Success(ArticleDetails(
          id: 1,
          text: 'text',
          title: 'title',
          authorName: 'authorName',
          imageUrl: 'url',
          authorDescription: 'authorDescription',
          htmlContent: '',
        ));
      });

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const LojongAppMock(home: ArticlesView()));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ArticleItemWidget).first);
        await tester.pumpAndSettle();

        expect(find.byType(ArticleDetailsView), findsOneWidget);
      });
    });
  });
}

final _articles = [
  Article(
    id: 1,
    title: 'O que é mindfulness?',
    imageUrl: 'https://example.com/mindfulness_article1_thumbnail.jpg',
    text: 'Mindfulness é a prática de estar consciente e presente no momento, '
        'sem julgamentos. Descubra mais sobre essa técnica de meditação.',
  ),
  Article(
    id: 2,
    title: 'Técnicas de Respiração',
    imageUrl: 'https://example.com/mindfulness_article2_thumbnail.jpg',
    text: 'Explore diferentes técnicas de respiração para acalmar a mente e '
        'melhorar a concentração durante a meditação.',
  ),
  Article(
    id: 3,
    title: 'Meditação Guiada para Iniciantes',
    imageUrl: 'https://example.com/mindfulness_article3_thumbnail.jpg',
    text: 'Esta meditação guiada é perfeita para iniciantes que desejam '
        'começar sua jornada de mindfulness. Siga as instruções e relaxe.',
  ),
];
