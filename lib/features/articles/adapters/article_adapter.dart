import '../models/article.dart';

abstract class ArticleAdapter {
  static Article fromMap(dynamic map) => Article(
        id: map['id'],
        title: map['title'],
        text: map['text'],
        imageUrl: map['image_url'],
      );

  static List<Article> fromList(List list) {
    return list.map(ArticleAdapter.fromMap).toList();
  }
}
