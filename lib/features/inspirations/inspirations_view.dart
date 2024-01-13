import 'package:flutter/material.dart';

import '../../common/components/tabbar_template.dart';
import '../../utils/extensions/context_extensions.dart';

class InspirationsView extends StatefulWidget {
  const InspirationsView({super.key});

  @override
  State<InspirationsView> createState() => _InspirationsViewState();
}

class _InspirationsViewState extends State<InspirationsView> {
  @override
  Widget build(BuildContext context) {
    return TabBarTemplate(
      title: context.l10n.appTitle,
      tabLabels: [
        context.l10n.inspirationsVideosTabLabel,
        context.l10n.inspirationsArticlesTabLabel,
        context.l10n.inspirationsQuotesTabLabel,
      ],
      tabViews: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.white,
        ),
        Container(
          color: Colors.pink,
        ),
      ],
    );
  }
}
