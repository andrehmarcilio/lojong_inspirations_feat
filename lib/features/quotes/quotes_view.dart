import 'package:flutter/material.dart';

import '../../common/components/paginated_list_view.dart';
import '../../common/placeholders/error_placeholder.dart';
import '../../common/placeholders/loading_placeholder.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/service_locator/service_locator.dart';
import 'components/quote_item_widget.dart';
import 'models/quote.dart';
import 'quotes_view_model.dart';

enum QuotesState { initial, loading, success, failure }

class QuotesView extends StatefulWidget {
  const QuotesView({super.key});

  @override
  State<QuotesView> createState() => _QuotesViewState();
}

class _QuotesViewState extends State<QuotesView> with AutomaticKeepAliveClientMixin {
  final viewModel = serviceLocator.get<QuotesViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.loadQuotes();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return switch (viewModel.state) {
          QuotesState.initial || QuotesState.loading => const Center(child: LoadingPlaceholder()),
          QuotesState.success => _QuotesSuccessView(
              paginationManager: viewModel,
              quotes: viewModel.quotes,
            ),
          QuotesState.failure => _QuotesErrorView(
              errorMessage: viewModel.errorMessage?.getMessage(context.l10n) ?? '',
            ),
        };
      },
    );
  }
}

class _QuotesSuccessView extends StatelessWidget {
  final List<Quote> quotes;
  final PaginationManager paginationManager;

  const _QuotesSuccessView({
    required this.quotes,
    required this.paginationManager,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedListView.separated(
      paginationManager: paginationManager,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: quotes.length,
      itemBuilder: (_, index) {
        final quote = quotes[index];

        return QuoteItemWidget(
          quote: quote,
          index: index,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}

class _QuotesErrorView extends StatelessWidget {
  final String errorMessage;

  const _QuotesErrorView({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ErrorPlaceholder(
                  title: context.l10n.commonsDefaultErrorMessageTitle,
                  description: errorMessage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
