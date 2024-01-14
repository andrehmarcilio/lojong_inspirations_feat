// import '../../common/models/app_exception_messages.dart';
// import 'articles_view.dart';
// import 'models/article.dart';

// class ArticleViewState {
//   final bool hasNextPage;
//   final ArticlesState state;
//   final List<Article> articles;
//   final AppExceptionMessages? errorMessage;

//   ArticleViewState addArticles(List<Article> articles) {
//     final refreshedArticles = [...this.articles, ...articles];
//   }

//   ArticleViewState.initial()
//       : articles = [],
//         hasNextPage = true,
//         errorMessage = null,
//         state = ArticlesState.initial;

//   ArticleViewState.loading()
//       : articles = [],
//         hasNextPage = true,
//         errorMessage = null,
//         state = ArticlesState.loading;

//   ArticleViewState.failure({required this.errorMessage})
//       : articles = [],
//         hasNextPage = true,
//         state = ArticlesState.failure;

//   ArticleViewState.success({required this.articles})
//       : hasNextPage = true,
//         errorMessage = null,
//         state = ArticlesState.success;
// }
