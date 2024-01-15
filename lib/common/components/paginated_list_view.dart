import 'package:flutter/material.dart';

import '../../utils/throttle.dart';

abstract interface class PaginationManager {
  int get currentPage;
  bool get hasNextPage;

  Future<void> loadMoreContent(int page);
}

class PaginatedListView extends StatefulWidget {
  final int itemCount;
  final EdgeInsets? padding;
  final PaginationManager paginationManager;
  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;

  const PaginatedListView.builder({
    required this.padding,
    required this.itemCount,
    required this.itemBuilder,
    required this.paginationManager,
    super.key,
  }) : separatorBuilder = null;

  const PaginatedListView.separated({
    required this.padding,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.paginationManager,
    super.key,
  });

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final _scrollThorttleHandler = Throttle(minDelay: const Duration(milliseconds: 400));
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_setRequestPageListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final separatorBuilder = widget.separatorBuilder;

    if (separatorBuilder != null) {
      return ListView.separated(
        padding: widget.padding,
        itemBuilder: widget.itemBuilder,
        itemCount: widget.itemCount,
        controller: _scrollController,
        separatorBuilder: separatorBuilder,
      );
    }

    return ListView.builder(
      padding: widget.padding,
      itemBuilder: widget.itemBuilder,
      itemCount: widget.itemCount,
      controller: _scrollController,
    );
  }

  void _setRequestPageListener() {
    final reachedTriggerPosition = _scrollController.position.pixels >= _nextPageLoadPositionTrigger;
    final canSendNewRequest = reachedTriggerPosition && widget.paginationManager.hasNextPage;

    if (canSendNewRequest) {
      final nextPage = widget.paginationManager.currentPage + 1;

      _scrollThorttleHandler.call(() async {
        await widget.paginationManager.loadMoreContent(nextPage);
      });
    }
  }

  double get _nextPageLoadPositionTrigger {
    return _scrollController.position.maxScrollExtent * _nextPageTriggerFraction;
  }

  double get _nextPageTriggerFraction {
    const scrollFractionTrigger = 0.8;
    final scrollableAreaFraction = 1 / widget.paginationManager.currentPage;
    final pagesAlreadyScrolled = widget.paginationManager.currentPage - 1;

    final alreadyScrolledFraction = pagesAlreadyScrolled * scrollableAreaFraction;
    final newScrollableArea = scrollFractionTrigger * scrollableAreaFraction;

    return alreadyScrolledFraction + newScrollableArea;
  }
}
