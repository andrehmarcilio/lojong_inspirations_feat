import '../../common/models/app_exception_messages.dart';
import 'models/article_details.dart';

sealed class ArticleDetailsState {}

class ArticleDetailsInitial extends ArticleDetailsState {}

class ArticleDetailsLoading extends ArticleDetailsState {}

class ArticleDetailsSuccess extends ArticleDetailsState {
  final ArticleDetails article;

  ArticleDetailsSuccess({required this.article});
}

class ArticleDetailsFailure extends ArticleDetailsState {
  final AppExceptionMessages errorMessage;

  ArticleDetailsFailure({required this.errorMessage});
}
