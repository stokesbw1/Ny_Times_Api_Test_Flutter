import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String uri;
  final String url;
  final int id;
  final int assertId;
  final String source;
  final DateTime updated;
  final String section;
  final String nytdsection;
  final List<String> adxKeywords;
  final String byline;
  final String title;
  final String heroImage;

  const Article({
    required this.uri,
    required this.url,
    required this.id,
    required this.assertId,
    required this.source,
    required this.updated,
    required this.section,
    required this.nytdsection,
    required this.adxKeywords,
    required this.byline,
    required this.title,
    required this.heroImage,
  });

  @override
  List<Object?> get props => [
        uri,
        url,
        id,
        assertId,
        source,
        updated,
        section,
        nytdsection,
        adxKeywords,
        byline,
        title,
        heroImage,
      ];
}
