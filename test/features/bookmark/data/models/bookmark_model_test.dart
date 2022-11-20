import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/models/bookmark_model.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tBookmark =  BookmarkModel(
    id: 100000008632049
  );

  test("Should be a subclass of Article entity", () {
    // Assert
    expect(tBookmark, isA<Bookmark>());
  });

  group('FromMap', () {
    test('Should return valid map model when the correct map is passed', () {
      // Arrange
      final jsoMmap = jsonDecode(fixture('bookmark.json'));

      // Act
      final result = jsoMmap.map((bookmark) => BookmarkModel.fromMap(map: bookmark as Map<String, dynamic>));

      // Assert
      expect(result, [tBookmark]);
    });
  });
}
