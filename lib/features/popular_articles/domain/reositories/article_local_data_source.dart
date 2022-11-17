import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

abstract class ArticleLocalDataSource {
  Future<void> cacheArticles({required List<ArticleModel> articles});
  Future<List<ArticleModel>> getLastCachedArticles();
}
