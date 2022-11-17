import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/usecases/get_articles.dart';
import 'package:ny_times_api_test_flutter/injection_container.dart';
import 'package:stacked/stacked.dart';

class ArticlesScreenViewModel extends BaseViewModel {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  Future<void> getArticles() async {
    setBusy(true);
    final GetArticles getArticles = sl();

    final either = await getArticles(const NoParams());
    either.fold((failure) {
      print("Failed to get Applications");
    }, (List<Article> articles) {
      _articles = articles;
    });

    setBusy(false);
  }
}
