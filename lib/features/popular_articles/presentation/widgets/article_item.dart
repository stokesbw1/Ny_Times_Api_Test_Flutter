import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/domain/entities/bookmark.dart';
import 'package:ny_times_api_test_flutter/features/bookmark/presentation/cubit/bookmark_cubit.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final bool isConnected;

  const ArticleItem(
      {super.key, required this.article, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: isConnected && article.heroImage.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      height: 70,
                      width: 70,
                      placeholder: "assets/images/nyt_placeholder.png",
                      image: article.heroImage)
                  : Image.asset(
                      height: 70,
                      width: 70,
                      "assets/images/nyt_placeholder.png"),
            ),
            Expanded(
              child: Container(
                // height: 70,
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          height: 1.2,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      article.byline,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.displayMedium,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // BookmarkIcon(id: article.id),
            IconButton(
              onPressed: () {
                context
                    .read<BookmarkCubit>()
                    .toggleBookmarks(toggleId: article.id);
              },
              icon: Icon(
                article.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
