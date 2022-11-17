import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/core/usecases/usecase.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_repository.dart';

class GetArticles implements Usecase<List<Article>, NoParams> {
  final ArticleRepository repository;

  GetArticles({required this.repository});

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getArticles();
  }
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
