import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/core/usecases/usecase.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/repository/bookmark_repository.dart';

class GetBookmarks implements Usecase<List<Bookmark>, GetBookmarkNoParams> {
  final BookmarkRepository repository;

  GetBookmarks({required this.repository});

  @override
  Future<Either<Failure, List<Bookmark>>> call(
      GetBookmarkNoParams params) async {
    return await repository.getBookmarks();
  }
}

class GetBookmarkNoParams extends Equatable {
  const GetBookmarkNoParams();

  @override
  List<Object?> get props => [];
}
