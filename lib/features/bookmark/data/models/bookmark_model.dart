import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';

class BookmarkModel extends Bookmark {
  const BookmarkModel({required id, required isBookmarked})
      : super(id: id, isBookmarked: isBookmarked);

  factory BookmarkModel.fromMap({required Map<String, dynamic> map}) {
    return BookmarkModel(id: map["id"], isBookmarked: map["isBookmarked"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "isBookmarked": isBookmarked,
    };
  }
}
