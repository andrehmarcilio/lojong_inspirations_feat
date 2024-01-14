import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/data/services/article_service.dart';
import 'package:lojong_test_app/features/articles/models/pagination_with_articles.dart';
import 'package:lojong_test_app/features/articles/use_cases/get_articles_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class ArticleServiceMock extends Mock implements ArticleService {}

void main() {
  group('GetArticlesUseCase |', () {
    late GetArticlesUseCase getArticlesUseCase;
    late ArticleServiceMock articleService;

    setUp(() {
      articleService = ArticleServiceMock();
      getArticlesUseCase = GetArticlesUseCaseImpl(articleService: articleService);
    });

    test('should return a list of Articles when Articles services returns a success result', () async {
      when(() => articleService.getArticles(page: 1)).thenAnswer((_) => Success(_mockedArticles));

      final result = await getArticlesUseCase(page: 1);

      expect(result.successData, isA<PaginationWithArticles>());
    });

    test('should return an exceptionMessage when Articles services returns a failure result', () async {
      when(() => articleService.getArticles(page: 1)).thenAnswer((_) => Failure(AppExceptionMessages.serverSide));

      final result = await getArticlesUseCase(page: 1);

      expect(result.failureData, AppExceptionMessages.serverSide);
    });
  });
}

final _mockedArticles = {
  'has_more': false,
  'current_page': 5,
  'last_page': 5,
  'next_page': false,
  'list': [
    {
      'id': 10,
      'text':
          'A história de uma aventura que desafia os limites do corpo e da mente. Eliane Brum fez um retiro de meditação de dez dias, no interior do Rio de Janeiro. ',
      'title': 'O relato de um retiro de 10 dias de meditação',
      'image_url': 'https://d2g3qjbxchhsv1.cloudfront.net/images/artigos/limite.png',
      'author_name': 'Eliane Brum',
      'url': 'https://lojongapp.com/blog/article/10/o-relato-de-um-retiro-de-10-dias-de-meditacao',
      'premium': 0,
      'order': 9,
      'image': 'https://d2g3qjbxchhsv1.cloudfront.net/images/artigos/limite.png'
    },
    {
      'id': 13,
      'text':
          'Ao longo do dia, você pode parar e acordar para a mágica do mundo ao seu redor. Pema Chödrön fala sobre como esse tipo de prática de atenção plena, ampla e acessível, é a coisa mais importante que podemos fazer em nossas vidas.',
      'title': 'Acordando para o seu mundo',
      'image_url': 'https://d2g3qjbxchhsv1.cloudfront.net/artigos/pemaatricle.png',
      'author_name': 'Pema Chödrön',
      'url': 'https://lojongapp.com/blog/article/13/acordando-para-o-seu-mundo',
      'premium': 0,
      'order': 9,
      'image': 'https://d2g3qjbxchhsv1.cloudfront.net/artigos/pemaatricle.png'
    },
    {
      'id': 14,
      'text':
          'O passado dói e gatilhos emocionais possuem um modo de nos manter presos em nossos caminhos. A prática de deixar que tudo se vá nos ajuda a seguir em frente.',
      'title': 'Uma prática de atenção plena que você pode tentar hoje: deixar ir!',
      'image_url': 'https://d2g3qjbxchhsv1.cloudfront.net/artigos/baloon.png',
      'author_name': 'Ed Halliwell',
      'url': 'https://lojongapp.com/blog/article/14/uma-pratica-de-atencao-plena-que-voce-pode-tentar-hoje-deixar-ir',
      'premium': 0,
      'order': 10,
      'image': 'https://d2g3qjbxchhsv1.cloudfront.net/artigos/baloon.png'
    },
    {
      'id': 15,
      'text':
          'A medida que contemplamos a enorme variedade de fatores que devem se unir para produzir um senso específico de individualidade, nosso apego a esse “eu” que achamos que somos começa a se desfazer.',
      'title': 'Tudo muda, até o “eu” muda',
      'image_url': 'https://d2g3qjbxchhsv1.cloudfront.net/artigos/dentedele.png',
      'author_name': 'Mingyur Rinpoche',
      'url': 'https://lojongapp.com/blog/article/15/tudo-muda-ate-o-eu-muda',
      'premium': 0,
      'order': 10,
      'image': 'https://d2g3qjbxchhsv1.cloudfront.net/artigos/dentedele.png'
    },
  ]
};
