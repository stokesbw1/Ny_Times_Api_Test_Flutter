import 'package:dartz/dartz.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/models/bookmark_model.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, List<Bookmark>>> getBookmarks();
  Future<Either<Failure, Bookmark>>  toggleBookmark(
      {required Bookmark bookmark});
}
