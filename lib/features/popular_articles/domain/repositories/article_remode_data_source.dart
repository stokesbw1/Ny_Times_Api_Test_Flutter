import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/reposetories/article_repository_impl.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
}
