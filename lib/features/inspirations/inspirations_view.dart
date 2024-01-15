import 'package:flutter/material.dart';

import '../../common/components/tabbar_template.dart';
import '../../utils/extensions/context_extensions.dart';
import '../articles/articles_view.dart';
import '../quotes/quotes_view.dart';
import '../videos/videos_view.dart';

class InspirationsView extends StatelessWidget {
  const InspirationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarTemplate(
      title: context.l10n.inspirationsTitle,
      tabLabels: [
        context.l10n.inspirationsVideosTabLabel,
        context.l10n.inspirationsArticlesTabLabel,
        context.l10n.inspirationsQuotesTabLabel,
      ],
      tabViews: const [
        VideosView(),
        ArticlesView(),
        QuotesView(),
      ],
    );
  }
}
