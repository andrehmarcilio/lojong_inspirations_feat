import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/features/article_details/adapters/article_details_adapter.dart';
import 'package:lojong_test_app/features/article_details/models/article_details.dart';

void main() {
  group('ArticleDetails Adapter |', () {
    test('should return a ArticleDetails when converting api reponse body', () {
      final articleDetails = ArticleDetailsAdapter.fromMap(_mockedArticleDetails);

      expect(articleDetails, isA<ArticleDetails>());
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
