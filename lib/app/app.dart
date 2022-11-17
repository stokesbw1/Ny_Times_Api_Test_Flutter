import 'package:ny_times_api_test_flutter/features/popular_articles/presentation/articles_screens.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes:  [
    MaterialRoute(page: ArticlesScreen, initial: true),
  ],
logger: StackedLogger()
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}