import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String uri;
  final String url;
  final int id;
  final int assertId;
  final String source;
  final String section;
  final String nytdsection;
  final String byline;
  final String title;
  final String heroImage;
  bool isBookmarked;

  Article({
    required this.uri,
    required this.url,
    required this.id,
    required this.assertId,
    required this.source,
    required this.section,
    required this.nytdsection,
    required this.byline,
    required this.title,
    required this.heroImage,
    this.isBookmarked = false,
  });

  @override
  List<Object?> get props => [
        uri,
        url,
        id,
        assertId,
        source,
        section,
        nytdsection,
        byline,
        title,
        heroImage,
        isBookmarked,
      ];
}
