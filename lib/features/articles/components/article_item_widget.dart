import 'package:flutter/material.dart';

import '../../../common/components/content_section_widget.dart';
import '../../article_details/article_details_view.dart';
import '../models/article.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;

  const ArticleItemWidget({
    required this.article,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ArticleDetailsView(articleId: article.id),
        ));
      },
      child: ContentSectionWidget(
        title: article.title,
        description: article.text,
        imageUrl: article.imageUrl,
      ),
    );
  }
}
