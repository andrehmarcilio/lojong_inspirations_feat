import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/features/quotes/adapters/quote_adapter.dart';
import 'package:lojong_test_app/features/quotes/models/quote.dart';

void main() {
  group('Quote Adapter |', () {
    test('should return a Quote when converting one item of api reponse body', () {
      final quote = QuoteAdapter.fromMap(_mockedQuote);

      expect(quote, isA<Quote>());
    });
    test('should return a Quote List when converting the entire api reponse body', () {
      final quotes = QuoteAdapter.fromList(_mockedQuotes);

      expect(quotes, isA<List<Quote>>());
    });
  });
}

final _mockedQuote = {
  'id': 60,
  'text':
      '"Por que você precisa meditar? Porque se você não praticar, eu te garanto que sua mente vai brincar com você, feliz e depois triste, animada e desanimada, mal humorada e depressiva, e depois excitada e sem controle, apenas seguindo o que sente. A meditação o ajuda a encontrar equilíbrio em sua vida. Por favor, entenda que equilíbrio vem de dentro, do relacionamento com sua própria mente, não tem nada a ver com o que acontece do lado de fora."',
  'author': 'Phakchok Rinpoche',
  'order': 1
};

final _mockedQuotes = [
  {
    'id': 60,
    'text':
        '"Por que você precisa meditar? Porque se você não praticar, eu te garanto que sua mente vai brincar com você, feliz e depois triste, animada e desanimada, mal humorada e depressiva, e depois excitada e sem controle, apenas seguindo o que sente. A meditação o ajuda a encontrar equilíbrio em sua vida. Por favor, entenda que equilíbrio vem de dentro, do relacionamento com sua própria mente, não tem nada a ver com o que acontece do lado de fora."',
    'author': 'Phakchok Rinpoche',
    'order': 1
  },
  {
    'id': 83,
    'text':
        '"A única diferença entre a meditação e o aprofundamento de uma amizade é que, no primeiro caso, o amigo que aprendem a conhecer pouco a pouco são vocês mesmos."',
    'author': 'Mingyur Rinpoche',
    'order': 1
  },
  {
    'id': 132,
    'text':
        'Lavar as mãos em mindfulness: ao ensaboar (20 segundos no mínimo), respire profundamente e pense em 3 coisas pelas quais você sente gratidão. \r\nAo enxaguar, traga a atenção ao corpo, note as sensações dele. Perceba o corpo respirando. \r\nFeche a torneira e respire profundamente 3 vezes. Não tente mudar nada, apenas mantenha-se consciente e aberto para o momento presente.',
    'author': 'Busque levar essa qualidade para o resto do dia.',
    'order': 1,
  }
];
