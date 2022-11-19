import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ny_times_api_test_flutter/core/network/network_info.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/usecases/get_articles.dart';
import 'package:ny_times_api_test_flutter/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final GetArticles usecase;
  final NetworkInfo networkInfo;

  ArticleCubit({required this.usecase, required this.networkInfo})
      : super(ArticleInitial());

  // Load articles
  Future<void> getArticles() async {
    // Emmit loading state
    emit(ArticleLoading());
    bool isConnected = await networkInfo.isConnected;

    final either = await usecase(const NoParams());
    either.fold((failure) {
      // Emmit success state
      emit(ArticleError());
    }, (List<Article> articles) {
      // Emmit success state
      emit(ArticleSuccess(articles: articles, isConnected: isConnected));
    });
  }

  // Load article in browser
  Future<void> launchArticleInBrowser({required String url}) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      // Emit error loading browser
      emit(ArticleErrorLoadingBrowser(url: url));
    }
  }
}
