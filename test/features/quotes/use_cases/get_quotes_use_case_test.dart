import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/common/models/app_exception_messages.dart';
import 'package:lojong_test_app/data/services/quote_service.dart';
import 'package:lojong_test_app/features/quotes/models/pagination_with_quotes.dart';
import 'package:lojong_test_app/features/quotes/use_cases/get_quotes_use_case.dart';
import 'package:lojong_test_app/utils/either.dart';
import 'package:mocktail/mocktail.dart';

class QuoteServiceMock extends Mock implements QuoteService {}

void main() {
  group('GetQuotesUseCase |', () {
    late GetQuotesUseCase getQuotesUseCase;
    late QuoteServiceMock quoteService;

    setUp(() {
      quoteService = QuoteServiceMock();
      getQuotesUseCase = GetQuotesUseCaseImpl(quoteService: quoteService);
    });

    test('should return a list of Quotes when Quotes services returns a success result', () async {
      when(() => quoteService.getQuotes(page: 1)).thenAnswer((_) => Success(_mockedQuotes));

      final result = await getQuotesUseCase(page: 1);

      expect(result.successData, isA<PaginationWithQuotes>());
    });

    test('should return an exceptionMessage when Quotes services returns a failure result', () async {
      when(() => quoteService.getQuotes(page: 1)).thenAnswer((_) => Failure(AppExceptionMessages.serverSide));

      final result = await getQuotesUseCase(page: 1);

      expect(result.failureData, AppExceptionMessages.serverSide);
    });
  });
}

final _mockedQuotes = {
  'has_more': true,
  'current_page': 1,
  'last_page': 32,
  'next_page': 2,
  'list': [
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
    },
  ]
};
