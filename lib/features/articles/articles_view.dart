import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import '../../common/components/paginated_list_view.dart';
import '../../common/placeholders/error_placeholder.dart';
import '../../common/placeholders/loading_placeholder.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/service_locator/service_locator.dart';
import 'articles_view_model.dart';
import 'components/article_item_widget.dart';
import 'models/article.dart';

enum ArticlesState { initial, loading, success, failure }

class ArticlesView extends StatefulWidget {
  const ArticlesView({super.key});

  @override
  State<ArticlesView> createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> with AutomaticKeepAliveClientMixin {
  final viewModel = serviceLocator.get<ArticlesViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.loadArticles();
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
          ArticlesState.initial || ArticlesState.loading => const Center(child: LoadingPlaceholder()),
          ArticlesState.success => _ArticlesSuccessView(
              paginationManager: viewModel,
              articles: viewModel.articles,
            ),
          ArticlesState.failure => _ArticlesErrorView(
              errorMessage: viewModel.errorMessage?.getMessage(context.l10n) ?? '',
            ),
        };
      },
    );
  }
}

class _ArticlesSuccessView extends StatelessWidget {
  final List<Article> articles;
  final PaginationManager paginationManager;

  const _ArticlesSuccessView({
    required this.articles,
    required this.paginationManager,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedListView.separated(
      paginationManager: paginationManager,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      itemCount: articles.length,
      itemBuilder: (_, index) {
        final article = articles[index];
        return ArticleItemWidget(article: article);
      },
      separatorBuilder: (_, __) => Divider(
        thickness: .4,
        color: AppColors.grey.withOpacity(0.5),
      ),
    );
  }
}

class _ArticlesErrorView extends StatelessWidget {
  final String errorMessage;

  const _ArticlesErrorView({required this.errorMessage});

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
