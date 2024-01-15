import '../models/quote.dart';

abstract class QuoteAdapter {
  static Quote fromMap(dynamic map) => Quote(
        id: map['id'],
        text: map['text'],
        author: map['author'],
      );

  static List<Quote> fromList(List list) {
    return list.map(QuoteAdapter.fromMap).toList();
  }
}
