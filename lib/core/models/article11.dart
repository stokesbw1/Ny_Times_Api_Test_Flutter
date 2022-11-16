class Article11{
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

  Article11({
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

  factory Article11.fromMap({required Map<String, dynamic> map}) {
    return Article11(
      uri: map["uri"],
      url: map["url"],
      id: map["id"],
      assertId: map["asset_id"],
      source: map["source"],
      updated: map["updated"],
      section: map["section"],
      nytdsection: map["nytdsection"],
      adxKeywords: map["adx_keywords"],
      byline: map["byline"],
      title: map["title"],
      heroImage: map["media"][0]["media-metadata"][0]["url"] ?? "",
    );
  }
}
