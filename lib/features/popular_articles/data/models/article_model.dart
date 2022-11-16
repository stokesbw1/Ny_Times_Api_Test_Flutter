import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required uri,
    required url,
    required id,
    required assertId,
    required source,
    required updated,
    required section,
    required nytdsection,
    required adxKeywords,
    required byline,
    required title,
    required heroImage,
  }) : super(
          uri: uri,
          url: url,
          id: id,
          assertId: assertId,
          source: source,
          updated: updated,
          section: section,
          nytdsection: nytdsection,
          adxKeywords: adxKeywords,
          byline: byline,
          title: title,
          heroImage: heroImage,
        );

  factory ArticleModel.fromMap({required Map<String, dynamic> map}) {
    return ArticleModel(
      uri: map["uri"],
      url: map["url"],
      id: map["id"],
      assertId: map["asset_id"],
      source: map["source"],
      updated: DateTime.parse("2022-11-13 09:20:43"),
      section: map["section"],
      nytdsection: map["nytdsection"],
      adxKeywords: map["adx_keywords"].split(";"),
      byline: map["byline"],
      title: map["title"],
      heroImage: map["media"][0]["media-metadata"][0]["url"] ?? "",
    );
  }
}
