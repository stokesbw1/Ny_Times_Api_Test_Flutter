import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/models/article_model.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tArticleModel = ArticleModel(
    uri: "nyt://article/25bfc8fb-0081-5105-a9b7-e8dd8ff991df",
    url:
        "https://www.nytimes.com/2022/11/12/science/cat-talking-owners-voice-dog.html",
    id: 100000008632049,
    assertId: 100000008632049,
    source: "New York Times",
    updated: DateTime.parse("2022-11-13 09:20:43"),
    section: "Science",
    nytdsection: "science",
    adxKeywords:
        "Cats;Pets;Animal Behavior;Animal Cognition;Research;your-feed-science;Animal Cognition (Journal)"
            .split(";"),
    byline: "By Anthony Ham",
    title: "Your Cat Might Not Be Ignoring You When You Speak",
    heroImage:
        "https://static01.nyt.com/images/2022/11/10/science/00tb-cats1/00tb-cats1-thumbStandard.jpg",
  );

  test("Should be a subclass of Article entity", () {
    // Assert
    expect(tArticleModel, isA<Article>());
  });

  group('FromMap', () {
    test('Should return valid map model when the correct map is passed', () {
      // Arrange
      final Map<String, dynamic> jsoMmap = jsonDecode(fixture('article.json'));

      // Act
      final result = ArticleModel.fromMap(map: jsoMmap["results"][0]);

      // Assert
      expect(result, tArticleModel);
    });
  });
}
