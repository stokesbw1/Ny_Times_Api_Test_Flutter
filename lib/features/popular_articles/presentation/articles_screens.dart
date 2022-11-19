import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ny_times_api_test_flutter/core/utils/show_toast.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/presentation/cubit/article_cubit.dart';
import 'package:ny_times_api_test_flutter/injection_container.dart';

class ArticlesScreen extends StatelessWidget {
  final ShowToast showToast;

  const ArticlesScreen({Key? key, required this.showToast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleCubit>(
        create: (context) => sl(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'NY Times Articles',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            backgroundColor: const Color(0xff47e4c1), // appbar color.
          ),
          body: BlocListener<ArticleCubit, ArticleState>(
            listener: (context, state) {
              if (state is ArticleInitial) {
                context.read<ArticleCubit>().getArticles();
              }

              if (state is ArticleErrorLoadingBrowser) {
                showToast.showToast(message: " Could not launch ${state.url}");
              }
            },
            child: BlocBuilder<ArticleCubit, ArticleState>(
              builder: (context, state) {
                if (state is ArticleInitial) {
                  context.read<ArticleCubit>().getArticles();
                }
                if (state is ArticleLoading || state is ArticleInitial) {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }
                if (state is ArticleError) {
                  return const Center(
                    child: Text("Reload"),
                  );
                }

                var successState = state as ArticleSuccess;

                return ListView.builder(
                  itemCount: successState.articles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.read<ArticleCubit>().launchArticleInBrowser(
                            url: successState.articles[index].url);
                      },
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              ClipOval(
                                child: FadeInImage.assetNetwork(
                                    height: 70,
                                    width: 70,
                                    placeholder:
                                        "assets/images/nyt_placeholder.png",
                                    image:
                                        successState.articles[index].heroImage),
                              ),
                              Flexible(
                                child: Container(
                                  // height: 70,
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          successState.articles[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: GoogleFonts.poppins(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                            height: 1.2,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        successState.articles[index].byline,
                                        style: GoogleFonts.poppins(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
