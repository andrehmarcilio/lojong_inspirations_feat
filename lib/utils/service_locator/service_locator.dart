import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../data/remote/http_client.dart';
import '../../data/services/article_service.dart';
import '../../data/services/quote_service.dart';
import '../../data/services/video_service.dart';
import '../../features/article_details/article_details_view_model.dart';
import '../../features/article_details/use_cases/get_article_details_use_case.dart';
import '../../features/articles/articles_view_model.dart';
import '../../features/articles/use_cases/get_articles_use_case.dart';
import '../../features/quotes/quotes_view_model.dart';
import '../../features/quotes/use_cases/get_quotes_use_case.dart';
import '../../features/videos/use_cases/get_videos_use_case.dart';
import '../../features/videos/videos_view_model.dart';
import '../session_manager.dart';

final serviceLocator = ServiceLocator();

class ServiceLocator {
  final _provider = GetIt.instance;

  T get<T extends Object>({dynamic param}) {
    return _provider.get<T>(param1: param);
  }

  void registerSingleton<T extends Object>(
    T instance, {
    FutureOr<dynamic> Function(T)? dispose,
  }) {
    _provider.registerSingleton<T>(instance, dispose: dispose);
  }

  void registerSingletonAsync<T extends Object>(
    Future<T> Function() asyncConstructor, {
    FutureOr<dynamic> Function(T)? dispose,
  }) {
    _provider.registerSingletonAsync<T>(asyncConstructor, dispose: dispose);
  }

  void registerFactory<T extends Object>(T Function() constructor) {
    _provider.registerFactory<T>(constructor);
  }

  void registerFactoryParam<T extends Object, ParamType>(T Function(ParamType param) constructor) {
    _provider.registerFactoryParam<T, ParamType, void>((param, _) => constructor.call(param));
  }

  void pushNewScope(void Function(ServiceLocator)? init) {
    _provider.pushNewScope(init: (_) => init?.call(serviceLocator));
  }

  Future<void> popScope() async {
    await _provider.popScope();
  }

  Future<void> reset() async {
    await _provider.reset();
  }

  Future<void> allReady() async {
    await _provider.allReady();
  }
}

void initializeDependencies() {
  // Singletons
  serviceLocator.registerSingleton<HttpClient>(DioHttpClient());

  serviceLocator.registerSingleton<SessionManager>(MockedSessionManager());

  // Services
  serviceLocator.registerFactory<VideoService>(() {
    return VideoServiceImpl(client: serviceLocator.get());
  });

  serviceLocator.registerFactory<ArticleService>(() {
    return ArticleServiceImpl(client: serviceLocator.get());
  });

  serviceLocator.registerFactory<QuoteService>(() {
    return QuoteServiceImpl(client: serviceLocator.get());
  });

  // UseCases
  serviceLocator.registerFactory<GetVideosUseCase>(() {
    return GetVideosUseCaseImpl(videoService: serviceLocator.get());
  });

  serviceLocator.registerFactory<GetArticlesUseCase>(() {
    return GetArticlesUseCaseImpl(articleService: serviceLocator.get());
  });

  serviceLocator.registerFactory<GetArticleDetailsUseCase>(() {
    return GetArticleDetailsUseCaseImpl(articleService: serviceLocator.get());
  });

  serviceLocator.registerFactory<GetQuotesUseCase>(() {
    return GetQuotesUseCaseImpl(quoteService: serviceLocator.get());
  });

  // ViewModels
  serviceLocator.registerFactory(() {
    return VideosViewModel(getVideosUseCase: serviceLocator.get());
  });

  serviceLocator.registerFactory(() {
    return ArticlesViewModel(getArticlesUseCase: serviceLocator.get());
  });

  serviceLocator.registerFactoryParam<ArticleDetailsViewModel, int>((articleId) {
    return ArticleDetailsViewModel(
      articleId: articleId,
      getArticleDetailsUseCase: serviceLocator.get(),
    );
  });

  serviceLocator.registerFactory(() {
    return QuotesViewModel(getQuotesUseCase: serviceLocator.get());
  });
}
