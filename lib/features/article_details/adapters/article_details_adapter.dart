import '../models/article_details.dart';

abstract class ArticleDetailsAdapter {
  static ArticleDetails fromMap(Map map) => ArticleDetails(
        id: map['id'],
        text: map['text'],
        title: map['title'],
        imageUrl: map['image_url'],
        authorName: map['author_name'],
        authorImg: map['author_image'],
        authorDescription: map['author_description'],
        htmlContent: map['full_text'],
      );
}
