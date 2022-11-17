import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

abstract class ArticleLocalDataSource {
  Future<void> cacheArticles({required List<Article> articles});
  Future<List<Article>> getLastCachedArticles();
}
