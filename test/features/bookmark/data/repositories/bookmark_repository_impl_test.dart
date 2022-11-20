import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/models/bookmark_model.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/repository/bookmark_repository_impl.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/repository/bookmark_local_datasource.dart';

import 'bookmark_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BookmarkLocalDataSoure>()])
void main() {
  late MockBookmarkLocalDataSoure dataSoure;
  late BookmarkRepositoryImpl repositoryImpl;

  setUp(() {
    dataSoure = MockBookmarkLocalDataSoure();
    repositoryImpl = BookmarkRepositoryImpl(dataSoure: dataSoure);
  });
  
  const tBookmarkModels = [BookmarkModel(id: 1)];
  const List<Bookmark> tBookmarks = tBookmarkModels;

  test('Should return list of bookmarks get bookmark is successful', () async {
    // Arrange
    when(dataSoure.getBookmarks()).thenAnswer((_) async => tBookmarkModels);

    // Act
    final result = await repositoryImpl.getBookmarks();

    // Assert
    verify(dataSoure.getBookmarks());
    expect(result, equals(const Right(tBookmarks)));
    verifyNoMoreInteractions(dataSoure);
  });

  test(
      'Should return cache failure when call to local data  source is unsuccessfull',
      () async {
    // Arrange
    when(dataSoure.getBookmarks()).thenThrow((_) async => CacheException());

    // Act
    final result = await repositoryImpl.getBookmarks();

    // Assert
    verify(dataSoure.getBookmarks());
    expect(result, equals(const Left(CacheFailure())));
    verifyNoMoreInteractions(dataSoure);
  });

  test('Should return verify that saveBookmarks in local datastore is called w', () async {
    // Arrange
    when(dataSoure.getBookmarks()).thenAnswer((_) async => tBookmarkModels);

    // Act
    final result = await repositoryImpl.toggleBookmark(bookmark: tBookmarkModels[0]);

    // Assert
    verify(dataSoure.getBookmarks());
    verifyNoMoreInteractions(dataSoure);
  });

  test(
      'Should return cache failure when call to local data source is unsuccessfull',
      () async {
    // Arrange
    when(dataSoure.getBookmarks()).thenThrow((_) async => CacheException());

    // Act
    final result =
        await repositoryImpl.toggleBookmark(bookmark: tBookmarkModels[0]);

    // Assert
    verify(dataSoure.getBookmarks());
    expect(result, equals(const Left(CacheFailure())));
    verifyNoMoreInteractions(dataSoure);
  });
}
