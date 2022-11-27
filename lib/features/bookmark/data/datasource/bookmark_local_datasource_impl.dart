import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/models/bookmark_model.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/repository/bookmark_local_datasource.dart';

import '../../../../app_constants/app_constants.dart';

class BookmarkLocalDatasourceImpl implements BookmarkLocalDataSoure {
  final FlutterSecureStorage storage;
  BookmarkLocalDatasourceImpl({required this.storage});

  @override
  Future<List<BookmarkModel>> getBookmarks() async {
    List<BookmarkModel> bookmarks = [];
    try {
      final jsonString =
          await storage.read(key: AppConstants.cachedBookmarks) ?? '';

      if (jsonString.isNotEmpty) {
        final List<dynamic> jsoMmap = jsonDecode(jsonString);
        bookmarks = jsoMmap
            .map((bookmark) =>
                BookmarkModel.fromMap(map: bookmark as Map<String, dynamic>))
            .toList();

        return bookmarks;
      } else {
        return bookmarks;
      }
    } catch (e) {
      return bookmarks;
    }
  }

  @override
  Future<void> toggleBookmark({required Bookmark model}) async {
    try {
      var cachedBookmarks = await getBookmarks();
      var passedBookmarkModel = BookmarkModel(id: model.id, isBookmarked: model.isBookmarked);

      if (cachedBookmarks.contains(passedBookmarkModel)) {
        cachedBookmarks
            .removeWhere((element) => element.id == passedBookmarkModel.id);
      } else {
        cachedBookmarks.add(BookmarkModel(id: model.id, isBookmarked: true));
      }

      List<Map<String, dynamic>> jsonMap =
          cachedBookmarks.map((bookmark) => bookmark.toMap()).toList();
      String jsonString = jsonEncode(jsonMap);

      await storage.write(key: AppConstants.cachedBookmarks, value: jsonString);
    } catch (e) {
      throw CacheException();
    }
  }
}
