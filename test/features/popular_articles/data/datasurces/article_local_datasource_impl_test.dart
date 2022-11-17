import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/datasources/article_local_data_source_impl.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'article_local_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
void main() {
  late MockFlutterSecureStorage secureStorage;
  late ArticleLocalDataSourseImpl localData;

  setUp(() {
    secureStorage = MockFlutterSecureStorage();
    localData = ArticleLocalDataSourseImpl(secureStorage: secureStorage);
  });

  group('Get last cached articles', () {
    final Map<String, dynamic> jsoMmap = jsonDecode(fixture('article.json'));
    final tArticleModels = [ArticleModel.fromMap(map: jsoMmap["results"][0])];

    test('Should return articles if they are present in the local storage',
        () async {
      //Arrange
      when(secureStorage.read(key: CACHED_ARTICLES))
          .thenAnswer((_) async => fixture('article.json'));

      // Act
      final result = await localData.getLastCachedArticles();

      // Assert
      verify(secureStorage.read(key: CACHED_ARTICLES));
      expect(result, equals(tArticleModels));
    });

    test('Throw cache exception when there are no cached articles', () {
      //Arrange
      when(secureStorage.read(key: CACHED_ARTICLES))
          .thenAnswer((_) async => '');

      // Act
      final result = localData.getLastCachedArticles;

      // Assert
      throwsA(const TypeMatcher<CacheException>());
    });
  });

  group('Cache Articles', () {
    final Map<String, dynamic> jsoMmap = jsonDecode(fixture('article.json'));
    final tArticleModels = [ArticleModel.fromMap(map: jsoMmap["results"][0])];

    final results = tArticleModels.map((article) => article.toMap()).toList();
    final String jsonString = jsonEncode({"results": results});

    test('Should call secure storage to cache articles', () {
      // Act
      localData.cacheArticles(articles: tArticleModels);

      // Assert
      verify(secureStorage.write(key: CACHED_ARTICLES, value: jsonString));
    });
  });
}
