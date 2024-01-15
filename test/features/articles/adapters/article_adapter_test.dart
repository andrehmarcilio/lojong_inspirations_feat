import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/features/articles/adapters/article_adapter.dart';
import 'package:lojong_test_app/features/articles/models/article.dart';

void main() {
  group('Article Adapter |', () {
    test('should return a Article when converting one item of api reponse body', () {
      final article = ArticleAdapter.fromMap(_mockedArticle);

      expect(article, isA<Article>());
    });
    test('should return a Article List when converting the entire api reponse body', () {
      final articles = ArticleAdapter.fromList(_mockedArticles);

      expect(articles, isA<List<Article>>());
    });
  });
}

final _mockedArticle = {
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
};

final _mockedArticles = [
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
];
