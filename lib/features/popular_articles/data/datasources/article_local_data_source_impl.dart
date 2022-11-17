import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/reositories/article_local_data_source.dart';

const CACHED_ARTICLES = 'CACHED_ARTICLES';

class ArticleLocalDataSourseImpl implements ArticleLocalDataSource {
  final FlutterSecureStorage secureStorage;

  ArticleLocalDataSourseImpl({required this.secureStorage});

  @override
  Future<void> cacheArticles({required List<ArticleModel> articles}) async {
    final results = articles.map((article) => article.toMap()).toList();
    final String jsonString = jsonEncode({"results": results});

    await secureStorage.write(key: CACHED_ARTICLES, value: jsonString);
  }

  @override
  Future<List<ArticleModel>> getLastCachedArticles() async {
    final jsonString = await secureStorage.read(key: CACHED_ARTICLES) ?? '';
    if (jsonString.isNotEmpty) {
      final Map<String, dynamic> jsoMmap = jsonDecode(jsonString);
      final tArticleModels = (jsoMmap["results"] as List<dynamic>)
          .map((article) =>
              ArticleModel.fromMap(map: article as Map<String, dynamic>))
          .toList();

      return tArticleModels;
    } else {
      throw CacheException();
    }
  }
}
