import 'package:flutter/material.dart';

import '../../../common/components/content_section_widget.dart';
import '../models/article.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;

  const ArticleItemWidget({
    required this.article,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContentSectionWidget(
      title: article.title,
      description: article.text,
      imageUrl: article.imageUrl,
    );
  }
}
