import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/core/network/network_info.dart';
import 'package:ny_times_api_test_flutter/core/utils/show_toast.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/reposetories/article_repository_impl.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_local_data_source.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_remode_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'article_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ArticleRemoteDataSource>()])
@GenerateNiceMocks([MockSpec<ArticleLocalDataSource>()])
@GenerateNiceMocks([MockSpec<NetworkInfoImpl>()])
@GenerateNiceMocks([MockSpec<ShowToast>()])
void main() {
  late MockArticleRemoteDataSource remoteData;
  late MockArticleLocalDataSource localData;
  late MockNetworkInfoImpl networkInfo;
  late ArticleRepositoryImpl repositoryImpl;
  late MockShowToast showToast;

  setUp(() {
    networkInfo = MockNetworkInfoImpl();
    remoteData = MockArticleRemoteDataSource();
    localData = MockArticleLocalDataSource();
    showToast = MockShowToast();

    repositoryImpl = ArticleRepositoryImpl(showToast:showToast,
        remoteData: remoteData, networkInfo: networkInfo, localData: localData);
  });

  group('get Articles', () {
    final Map<String, dynamic> jsoMmap = jsonDecode(fixture('article.json'));
    final tArticleModels = [ArticleModel.fromMap(map: jsoMmap["results"][0])];
    final List<Article> tArticles  = tArticleModels;

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

      test('Should show no internet connection toast message if offline',
          () async {
        // Arrange
        when(localData.getLastCachedArticles())
            .thenAnswer((_) async => tArticleModels);

        // Act
         await repositoryImpl.getArticles();

        // Assert
        verify(showToast.showToast(message: NO_CONNECTION_TOAST_MESSAGE, length: Toast.LENGTH_LONG));
        verifyNoMoreInteractions(showToast);
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
