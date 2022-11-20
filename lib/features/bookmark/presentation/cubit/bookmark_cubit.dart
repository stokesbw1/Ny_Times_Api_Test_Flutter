import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/usecases/get_bookmarks.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/usecases/toggle_bookmark.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final ToggleBookmark toggleUsecase;
  final GetBookmarks getBookmarksUsecase;

  BookmarkCubit(
      {required this.toggleUsecase, required this.getBookmarksUsecase})
      : super(BookmarkInitial());

  Future<void> getBookmarks() async {
    final either = await getBookmarksUsecase(const GetBookmarkNoParams());
    either.fold((failure) {}, (List<Bookmark> bookmarks) {
      // Emmit success state
      emit(BookmarkFetched(bookmarks: bookmarks));
    });
  }

  Future<void> toggleBookmarks({required int toggleId}) async {
    final either =
        await toggleUsecase(Params(bookmark: Bookmark(id: toggleId)));
    either.fold((failure) {
      print("toggleBookmarks({required int $toggleId}");
    }, (Bookmark bookmark) {
      // Emmit success state
      emit(BookmarkChanged(bookmark: bookmark));
      print("toggle successful");
    });
  }
}
