import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/presentation/cubit/bookmark_cubit.dart';
import 'package:ny_times_api_test_flutter/injection_container.dart';

class BookmarkIcon extends StatelessWidget {
  final int id;
  const BookmarkIcon({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        var bookmark = Bookmark(id: id);
        bool isBookmarked = false;
        if (state is BookmarkFetched) {
          isBookmarked = state.bookmarks.contains(bookmark);
        }
        return IconButton(
          onPressed: () {
            context
                .read<BookmarkCubit>()
                .toggleBookmarks(toggleId: bookmark.id);
          },
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
