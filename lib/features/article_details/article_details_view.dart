import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../common/components/my_app_bar.dart';
import '../../common/placeholders/error_placeholder.dart';
import '../../common/placeholders/loading_placeholder.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/service_locator/service_locator.dart';
import '../../utils/style_helpers.dart';
import 'article_details_state.dart';
import 'article_details_view_model.dart';
import 'models/article_details.dart';

class ArticleDetailsView extends StatefulWidget {
  final int articleId;

  const ArticleDetailsView({required this.articleId, super.key});

  @override
  State<ArticleDetailsView> createState() => _ArticleDetailsViewState();
}

class _ArticleDetailsViewState extends State<ArticleDetailsView> {
  late final viewModel = serviceLocator.get<ArticleDetailsViewModel>(param: widget.articleId);

  @override
  void initState() {
    super.initState();
    viewModel.loadArticleDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors(context).primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MyAppBar(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors(context).background,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ValueListenableBuilder(
                  valueListenable: viewModel.state,
                  builder: (context, articleState, _) {
                    return switch (articleState) {
                      ArticleDetailsInitial _ || ArticleDetailsLoading _ => const Center(child: LoadingPlaceholder()),
                      ArticleDetailsSuccess(:final article) => _ArticleDetailsSuccessView(article: article),
                      ArticleDetailsFailure(:final errorMessage) => _ArticleDetailsErrorView(
                          errorMessage: errorMessage.getMessage(context.l10n),
                        ),
                    };
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleDetailsSuccessView extends StatelessWidget {
  final ArticleDetails article;

  const _ArticleDetailsSuccessView({required this.article});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Material(
            elevation: 1.5,
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            article.title,
            textAlign: TextAlign.center,
            style: AppFonts(context).titleLarge,
          ),
          const SizedBox(height: 20),
          Html(data: article.htmlContent),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: AppColors(context).primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.authorImg != null) ...[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: article.authorImg ?? '',
                      height: 36,
                      width: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        article.authorImg != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                    children: [
                      Text(
                        article.authorName,
                        style: AppFonts(context).bodySmall,
                        textAlign: article.authorImg != null ? TextAlign.start : TextAlign.center,
                      ),
                      if (article.authorDescription != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          article.authorDescription ?? '',
                          style: AppFonts(context).labelSmall,
                          textAlign: article.authorImg != null ? TextAlign.start : TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ArticleDetailsErrorView extends StatelessWidget {
  final String errorMessage;

  const _ArticleDetailsErrorView({required this.errorMessage});

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
