import '../models/pagination.dart';

abstract class PaginationAdapter {
  static Pagination fromMap(Map map) => Pagination(
        currentPage: map['current_page'],
        hasNextPage: map['has_more'],
      );
}
