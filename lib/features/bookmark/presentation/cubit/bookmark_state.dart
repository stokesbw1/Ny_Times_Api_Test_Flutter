part of 'bookmark_cubit.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkFetched extends BookmarkState {
  final List<Bookmark> bookmarks;
  const BookmarkFetched({required this.bookmarks});

  @override
  List<Object> get props => [bookmarks];
}

class BookmarkChanged extends BookmarkState {
  final Bookmark bookmark;
  const BookmarkChanged({required this.bookmark});

  @override
  List<Object> get props => [bookmark];
}
