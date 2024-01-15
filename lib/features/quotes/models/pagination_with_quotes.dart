import '../../../common/models/pagination.dart';
import 'quote.dart';

class PaginationWithQuotes {
  final Pagination pagination;
  final List<Quote> quotes;

  PaginationWithQuotes({
    required this.pagination,
    required this.quotes,
  });
}
