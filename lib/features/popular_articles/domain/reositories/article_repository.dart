import 'package:dartz/dartz.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
}
