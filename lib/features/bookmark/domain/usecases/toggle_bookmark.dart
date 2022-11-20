import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/core/usecases/usecase.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/repository/bookmark_repository.dart';

class ToggleBookmark implements Usecase<Bookmark, Params> {
  final BookmarkRepository repository;

  ToggleBookmark({required this.repository});

  @override
  Future<Either<Failure, Bookmark>> call(Params params) async {
    return await repository.toggleBookmark(bookmark: params.bookmark);
  }
}

class Params extends Equatable {
  final Bookmark bookmark;
  const Params({required this.bookmark});

  @override
  List<Object?> get props => [bookmark];
}
