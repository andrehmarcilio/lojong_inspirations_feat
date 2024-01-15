import '../../../common/models/pagination.dart';
import 'article.dart';

class PaginationWithArticles {
  final Pagination pagination;
  final List<Article> articles;

  PaginationWithArticles({
    required this.pagination,
    required this.articles,
  });
}
