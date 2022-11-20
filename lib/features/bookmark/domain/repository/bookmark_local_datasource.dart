import 'package:ny_times_api_test_flutter/features/bookmark/data/models/bookmark_model.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';

abstract class BookmarkLocalDataSoure {
  Future<List<BookmarkModel>> getBookmarks();
  Future<void> toggleBookmark({required Bookmark model});
}
