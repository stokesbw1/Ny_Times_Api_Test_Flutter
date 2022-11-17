
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required uri,
    required url,
    required id,
    required assertId,
    required source,
    required section,
    required nytdsection,
    required byline,
    required title,
    required heroImage,
  }) : super(
          uri: uri,
          url: url,
          id: id,
          assertId: assertId,
          source: source,
          section: section,
          nytdsection: nytdsection,
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
      section: map["section"],
      nytdsection: map["nytdsection"],
      byline: map["byline"],
      title: map["title"],
      heroImage: map["media"][0]["media-metadata"][0]["url"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
          "uri": uri,
          "url": url,
          "id": id,
          "asset_id": assertId,
          "source": source,
          "section": section,
          "nytdsection": nytdsection,
          "byline": byline,
          "title": title,
          "media": [
            {
              "media-metadata": [
                {
                  "url": heroImage,
                },
              ]
            }
          ],
        };
  }
}
