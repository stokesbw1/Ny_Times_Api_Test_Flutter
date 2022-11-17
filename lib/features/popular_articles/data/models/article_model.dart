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
    String _heroImage = "";
    List<dynamic> media = map["media"];

    if (media.isNotEmpty) {
      List<dynamic> mediaMetadata =
          media [0]["media-metadata"];
      if (mediaMetadata.isNotEmpty) {
        _heroImage = mediaMetadata [0]["url"];
      } else {
        _heroImage = "";
      }
    } else {
      _heroImage = "";
    }

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
      heroImage: _heroImage,
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
