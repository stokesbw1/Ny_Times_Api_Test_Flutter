import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/core/platform/network_info.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/datasources/article_local_data_source.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/datasources/article_remode_data_source.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/reposetories/article_repository_impl.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/reositories/article_repository.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'article_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ArticleRemoteDataSource>()])
@GenerateNiceMocks([MockSpec<ArticleLocalDataSource>()])
@GenerateNiceMocks([MockSpec<NetworkInfo>()])
void main() {
  late MockArticleRemoteDataSource remoteData;
  late MockArticleLocalDataSource localData;
  late MockNetworkInfo networkInfo;
  late ArticleRepositoryImpl repositoryImpl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteData = MockArticleRemoteDataSource();
    localData = MockArticleLocalDataSource();

    repositoryImpl = ArticleRepositoryImpl(
        remoteData: remoteData, networkInfo: networkInfo, localData: localData);
  });

  group('get Articles', () {
    final Map<String, dynamic> jsoMmap = jsonDecode(fixture('article.json'));
    final tArticleModels = [ArticleModel.fromMap(map: jsoMmap["results"][0])];
    final tArticles = tArticleModels;

    test('Should check if device is online', () {
      // Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      repositoryImpl.getArticles();

      // Assert
      verify(networkInfo.isConnected);
    });

    group('Device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('Should return remote data if remote data source is successfull',
          () async {
        // Arrange
        when(remoteData.getArticles()).thenAnswer((_) async => tArticleModels);

        // Act
        final result = await repositoryImpl.getArticles();

        // Assert
        verify(remoteData.getArticles());
        expect(result, equals(Right(tArticles)));
        verifyNoMoreInteractions(remoteData);
      });

      test('Should cache data locally if remote data source is successfull',
          () async {
        // Arrange
        when(remoteData.getArticles()).thenAnswer((_) async => tArticleModels);

        // Act
        await repositoryImpl.getArticles();

        // Assert
        verify(remoteData.getArticles());
        verify(localData.cacheArticles(articles: tArticleModels));
        verifyNoMoreInteractions(localData);
      });

      test(
          'Should return server failure when call to remote data  source is unsuccessfull',
          () async {
        // Arrange
        when(remoteData.getArticles())
            .thenThrow((_) async =>  ServerException());

        // Act
        final result = await repositoryImpl.getArticles();

        // Assert
        verify(remoteData.getArticles());
        expect(result, equals(const Left(ServerFailure())));
        verifyZeroInteractions(localData);
      });
    });

    group('Device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('Should return lastly cached data when the cached data is present ',
          () async {
        // Arrange
        when(localData.getLastCachedArticles())
            .thenAnswer((_) async => tArticleModels);

        // Act
        final result = await repositoryImpl.getArticles();

        // Assert
        verify(localData.getLastCachedArticles());
        verifyZeroInteractions(remoteData);
        expect(result, equals(Right(tArticles)));
      });

      test('Should return cache failure when the cached data is not present ',
          () async {
        // Arrange
        when(localData.getLastCachedArticles())
            .thenThrow((_) async => CacheException());

        // Act
        final result = await repositoryImpl.getArticles();

        // Assert
        verify(localData.getLastCachedArticles());
        verifyZeroInteractions(remoteData);
        expect(result, equals(left(const CacheFailure())));
      });
    });
  });
}