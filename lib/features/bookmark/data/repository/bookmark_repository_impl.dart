import 'package:ny_times_api_test_flutter/core/error/exceptions.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/data/models/bookmark_model.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/repository/bookmark_local_datasource.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/repository/bookmark_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSoure dataSoure;

  BookmarkRepositoryImpl({required this.dataSoure});

  @override
  Future<Either<Failure, List<Bookmark>>> getBookmarks() async {
    try {
      List<BookmarkModel> bookmarks = await dataSoure.getBookmarks();
      return Right(bookmarks);
    } on CacheException {
      return left(const CacheFailure());
    } catch (e) {
      return left(const CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Bookmark>> toggleBookmark(
      {required Bookmark bookmark}) async {
    try {
     await dataSoure.toggleBookmark(model: bookmark);
      return Right(Bookmark(id: bookmark.id,isBookmarked: !bookmark.isBookmarked));
    } on CacheException {
      return left(const CacheFailure());
    } catch (e) {
      return left(const CacheFailure());
    }
  }
}
