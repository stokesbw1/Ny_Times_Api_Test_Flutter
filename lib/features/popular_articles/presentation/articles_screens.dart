import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/presentation/articles_screens_vm.dart';
import 'package:stacked/stacked.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArticlesScreenViewModel>.reactive(
      onModelReady: (model) {
        // model.getArticles();
      },
      builder: (context, model, child) {
        return Scaffold(
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
          body: model.isBusy
              ? const Center(
                  child: Text("Loading..."),
                )
              : ListView.builder(
                  itemCount: model.articles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        model.launchInBrowser(
                            Uri.parse(model.articles[index].url));
                      },
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage: NetworkImage(
                                    model.articles[index].heroImage),
                                backgroundColor: Colors.transparent,
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
                                          model.articles[index].title,
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
                                        model.articles[index].byline,
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
                ),
        );
      },
      viewModelBuilder: () => ArticlesScreenViewModel(),
    );
  }
}
