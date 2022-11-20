import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';

class BookmarkModel extends Bookmark {
  const BookmarkModel({required id}) : super(id: id);

  factory BookmarkModel.fromMap({required Map<String, dynamic> map}) {
    return BookmarkModel(id: map["id"]);
  }

  Map<String, dynamic> toMap() {
    return {"id": id};
  }
}
