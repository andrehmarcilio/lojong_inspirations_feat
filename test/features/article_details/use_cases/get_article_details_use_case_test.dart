import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/data/services/article_service.dart';
import 'package:lojong_test_app/features/article_details/models/article_details.dart';
import 'package:lojong_test_app/features/article_details/use_cases/get_article_details_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class ArticleServiceMock extends Mock implements ArticleService {}

void main() {
  group('GetArticleDetailsUseCase |', () {
    late GetArticleDetailsUseCaseImpl getArticleDetailsUseCase;
    late ArticleServiceMock articleService;

    setUp(() {
      articleService = ArticleServiceMock();
      getArticleDetailsUseCase = GetArticleDetailsUseCaseImpl(articleService: articleService);
    });

    test('should return an ArticleDetails when Article Service returns a success result', () async {
      when(() => articleService.getArticleDetails(articleId: 10)).thenAnswer((_) => Success(_mockedArticleDetails));

      final result = await getArticleDetailsUseCase(articleId: 10);

      expect(result.successData, isA<ArticleDetails>());
    });

    test('should return an exceptionMessage when Article Service returns a failure result', () async {
      when(() => articleService.getArticleDetails(articleId: 1)).thenAnswer((_) {
        return Failure(AppExceptionMessages.serverSide);
      });

      final result = await getArticleDetailsUseCase(articleId: 1);

      expect(result.failureData, AppExceptionMessages.serverSide);
    });
  });
}

final _mockedArticleDetails = {
  'id': 10,
  'text':
      'A história de uma aventura que desafia os limites do corpo e da mente. Eliane Brum fez um retiro de meditação de dez dias, no interior do Rio de Janeiro. ',
  'title': 'O relato de um retiro de 10 dias de meditação',
  'image_url': 'https://d2g3qjbxchhsv1.cloudfront.net/images/artigos/limite.png',
  'author_name': 'Eliane Brum',
  'url': 'https://lojongapp.com/blog/article/10/o-relato-de-um-retiro-de-10-dias-de-meditacao',
  'premium': 0,
  'order': 9,
  'full_text': '<p><em>Esta &eacute; a hist&oacute;ria de uma aventura que de</em></p>',
  'author_image': null,
  'author_description':
      'Jornalista, escritora e documentarista. Autora dos livros: Uma Duas , Coluna Prestes – O avesso da lenda, A vida que ninguém vê , O olho da rua - uma repórter em busca da literatura da vida real e A menina quebrada.',
  'image': 'https://d2g3qjbxchhsv1.cloudfront.net/images/artigos/limite.png'
};
