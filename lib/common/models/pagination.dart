class Pagination {
  final int currentPage;
  final bool hasNextPage;

  int get nextPage => currentPage + 1;

  Pagination({
    required this.currentPage,
    required this.hasNextPage,
  });

  Pagination.initial()
      : currentPage = 0,
        hasNextPage = true;
}
