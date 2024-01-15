class ArticleDetails {
  final int id;
  final String text;
  final String title;
  final String imageUrl;
  final String authorName;
  final String? authorDescription;
  final String? authorImg;
  final String htmlContent;

  ArticleDetails({
    required this.id,
    required this.text,
    required this.title,
    required this.imageUrl,
    required this.authorName,
    required this.authorDescription,
    required this.htmlContent,
    this.authorImg,
  });
}
