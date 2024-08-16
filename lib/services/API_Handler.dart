import 'dart:convert';

import 'package:flutter_newsapp_api/models/article_model.dart';

import 'package:http/http.dart' as http;

class ApiHandler {
  static Future<List<ArticleModel>> getData({String? limit}) async {
    List<ArticleModel> articles = [];
    try {
      String url =
          "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=41856323b2b047fc90e2706bd504f22a";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      List snap = [];

      if (data["status"] == "ok") {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            snap.add(element);
            articles = ArticleModel.articlesfromSnapshot(snap);
          }
        });
      }
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }

  static Future<List<ArticleModel>> getTopTrending({String? limit}) async {
    List<ArticleModel> articles = [];
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=41856323b2b047fc90e2706bd504f22a";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      List snap = [];

      if (data["status"] == "ok") {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            snap.add(element);
            articles = ArticleModel.articlesfromSnapshot(snap);
          }
        });
      }
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }

  static Future<List<ArticleModel>> getCategory(String category) async {
    List<ArticleModel> articles = [];
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=41856323b2b047fc90e2706bd504f22a";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      List snap = [];

      if (data["status"] == "ok") {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            snap.add(element);
            articles = ArticleModel.articlesfromSnapshot(snap);
          }
        });
      }
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }
}
