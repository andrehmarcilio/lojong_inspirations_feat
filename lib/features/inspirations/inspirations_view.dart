import 'package:flutter/material.dart';

import '../../common/components/tabbar_template.dart';
import '../../utils/extensions/context_extensions.dart';
import '../articles/articles_view.dart';
import '../videos/videos_view.dart';

class InspirationsView extends StatefulWidget {
  const InspirationsView({super.key});

  @override
  State<InspirationsView> createState() => _InspirationsViewState();
}

class _InspirationsViewState extends State<InspirationsView> {
  @override
  Widget build(BuildContext context) {
    return TabBarTemplate(
      title: context.l10n.inspirationsTitle,
      tabLabels: [
        context.l10n.inspirationsVideosTabLabel,
        context.l10n.inspirationsArticlesTabLabel,
        context.l10n.inspirationsQuotesTabLabel,
      ],
      tabViews: [
        const VideosView(),
        const ArticlesView(),
        Container(
          color: Colors.pink,
        ),
      ],
    );
  }
}
