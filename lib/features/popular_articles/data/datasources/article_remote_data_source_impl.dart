import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:http/http.dart' as http;
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_remode_data_source.dart';

const CACHED_ARTICLES = 'CACHED_ARTICLES';
const API_KEY = 'E2hefkconUOqsbqwFkyqSBCLeQZGOXh6';

class ArticleRemoteDataSourseImpl implements ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourseImpl({required this.client});

  @override
  Future<List<ArticleModel>> getArticles() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=$API_KEY'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final res = jsonDecode(await response.stream.bytesToString());


      final articleModels = (res["results"] as List<dynamic>)
          .map((article) => ArticleModel.fromMap(map: article as Map<String, dynamic>))
          .toList();



      return articleModels;
    } else {
      throw ServerException();
    }
  }
}
