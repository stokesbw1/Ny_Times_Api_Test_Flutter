import 'package:dartz/dartz.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/reositories/article_repository.dart';

class GetArticles {
  final ArticleRepository repository;

  GetArticles({required this.repository});

  Future<Either<Failure, List<Article>>> execute() async {
    return await repository.getArticles();
  }
}
