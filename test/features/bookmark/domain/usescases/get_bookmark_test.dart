import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/repository/bookmark_repository.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/usecases/get_bookmarks.dart';

import 'get_bookmark_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BookmarkRepository>()])
void main() {
  late MockBookmarkRepository repository;
  late GetBookmarks usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = GetBookmarks(repository: repository);
  });

  const tBookmarks = [Bookmark(id: 1)];

  
  test('Should get bokmarks from repository', () async {
    // Arrange
    when(repository.getBookmarks())
        .thenAnswer((_) async => const Right(tBookmarks));

    // Act
    var actual = await usecase(const GetBookmarkNoParams());

    // Assert
    expect(actual, const Right(tBookmarks));
    verify(repository.getBookmarks());
    verifyNoMoreInteractions(repository);
  });
}
