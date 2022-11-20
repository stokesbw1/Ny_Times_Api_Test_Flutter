import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ny_times_api_test_flutter/app_constants/app_constants.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/datasource/bookmark_local_datasource_impl.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/models/bookmark_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/datasources/article_local_data_source_impl.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/datasources/article_remote_data_source_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'bookmark_local_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
void main() {
  late MockFlutterSecureStorage storage;
  late BookmarkLocalDatasourceImpl datasourceImpl;

  setUp(() {
    storage = MockFlutterSecureStorage();
    datasourceImpl = BookmarkLocalDatasourceImpl(storage: storage);
  });

  group('Get bookmarks', () {
    final List<dynamic> jsoMmap = jsonDecode(fixture('bookmark.json'));
    final tBookmarkModels = jsoMmap
        .map((bookmark) =>
            BookmarkModel.fromMap(map: bookmark as Map<String, dynamic>))
        .toList();
    final List<BookmarkModel> tEmptyBookmarkModels = [];

    test('Should return bookmrks if they are present in the local storage',
        () async {
      //Arrange
      when(storage.read(key: AppConstants.cachedBookmarks))
          .thenAnswer((_) async => fixture('bookmark.json'));

      // Act
      final result = await datasourceImpl.getBookmarks();

      // Assert
      verify(storage.read(key: AppConstants.cachedBookmarks));
      expect(result, equals(tBookmarkModels));
    });

    test(
        'Should return empty bookmarks List if they are not present in the local storage',
        () async {
      //Arrange
      when(storage.read(key: AppConstants.cachedBookmarks))
          .thenAnswer((_) async => '');

      // Act
      final result = await datasourceImpl.getBookmarks();

      // Assert
      verify(storage.read(key: AppConstants.cachedBookmarks));
      expect(result, equals(tEmptyBookmarkModels));
    });
  });

  group('Cache bookmarks', () {
    const tBookmarkModel = BookmarkModel(id: 10);

    test('Should call secure storage to cache articles', () async {
      // Arange
      final String jsonString = jsonEncode([
        {"id": 10}
      ]);


      // Act
      await datasourceImpl.toggleBookmark(model: tBookmarkModel);

      // Assert
      verify(
          storage.write(key: AppConstants.cachedBookmarks, value: jsonString));
    });
  });
}
