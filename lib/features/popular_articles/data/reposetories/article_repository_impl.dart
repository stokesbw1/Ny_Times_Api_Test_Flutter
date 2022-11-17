import 'package:dartz/dartz.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/core/network/network_info.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/reositories/article_local_data_source.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/reositories/article_remode_data_source.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/reositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteData;
  final ArticleLocalDataSource localData;
  final NetworkInfoImpl networkInfo;

  ArticleRepositoryImpl(
      {required this.remoteData,
      required this.localData,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    List<ArticleModel> articles = [];
    if (await networkInfo.isConnected) {
      try {
        articles = await remoteData.getArticles();
        localData.cacheArticles(articles: articles);
      } on ServerException {
        return left(const ServerFailure());
      } catch (e) {
        return left(const ServerFailure());
      }

      return Right(articles);
    } else {
      try {
        articles = await localData.getLastCachedArticles();
        return right(articles);
      } on CacheException {
        return left(const CacheFailure());
      } catch (e) {
        return left(const CacheFailure());
      }
    }
  }
}
