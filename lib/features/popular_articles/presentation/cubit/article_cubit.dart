import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ny_times_api_test_flutter/core/network/network_info.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/usecases/get_bookmarks.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/presentation/cubit/bookmark_cubit.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/usecases/get_articles.dart';
import 'package:ny_times_api_test_flutter/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final GetArticles articlesUsecase;
  final GetBookmarks bookmarksUsecase;
  final NetworkInfo networkInfo;
  final BookmarkCubit bookmarkCubit;
  late StreamSubscription bookmarkSubstription;

  ArticleCubit(
      {required this.articlesUsecase,
      required this.bookmarksUsecase,
      required this.networkInfo,
      required this.bookmarkCubit})
      : super(ArticleInitial()) {
    bookmarkSubstription = bookmarkCubit.stream.listen((bookmarkState) async {
      if (bookmarkState is! BookmarkChanged) return;

      if (state is ArticleSuccess) {
        bool isConnected = await networkInfo.isConnected;

        var bookmarked = bookmarkState.bookmark;
        var articles = (state as ArticleSuccess).articles;

        for (var article in articles) {
          if (article.id == bookmarked.id) {
            article.isBookmarked = !article.isBookmarked;
            print(article.title);
            print(article.isBookmarked);
          }
        }

        emit(ArticleSuccess(articles: articles, isConnected: isConnected));
      }
    });
  }

  // Load articles
  Future<void> getArticles() async {
    // Emmit loading state
    emit(ArticleLoading());
    bool isConnected = await networkInfo.isConnected;

    // Get Bookmarked articles
    // assign isBookemarked to true for each bookmarked articles
    var bookmarkItemsEither =
        await bookmarksUsecase(const GetBookmarkNoParams());

    bookmarkItemsEither.fold((failure) {
      // Emmit success state
      emit(ArticleError());
    }, (List<Bookmark> bookmarks) async {
      final either = await articlesUsecase(const NoParams());

      either.fold((failure) {
        // Emmit success state
        emit(ArticleError());
      }, (List<Article> articles) {
        for (var article in articles) {
          for (var item in bookmarks) {
            article.isBookmarked = article.id == item.id;
          }
        }
        // Emmit success state
        emit(ArticleSuccess(articles: articles, isConnected: isConnected));
      });
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
