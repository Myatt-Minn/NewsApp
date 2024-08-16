import 'package:flutter/cupertino.dart';

class ArticleModel with ChangeNotifier {
  String? aurthor;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticleModel({
    this.aurthor,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    aurthor = json['aurthor'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
  static List<ArticleModel> articlesfromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ArticleModel.fromJson(data);
    }).toList();
  }
}
