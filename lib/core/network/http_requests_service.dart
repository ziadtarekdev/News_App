import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_cycle19_sun/core/config/app_constants.dart';
import 'package:news_app_cycle19_sun/core/network/end_points.dart';
import 'package:news_app_cycle19_sun/models/article_model.dart';
import 'package:news_app_cycle19_sun/models/source_model.dart';

abstract class HttpRequestsService {
  HttpRequestsService._();

  static Future<List<SourceModel>> getAllSources(String categoryID) async {
    /// need tool to fetch data from network
    /// HTTP
    final Map<String, dynamic> queryParameters = {
      "apiKey": AppConstants.apiKey,
      "category": categoryID,
    };
    final response = await http.get(
      Uri.https(AppConstants.baseURL, EndPoints.allSources, queryParameters),
    );

    final decodedData = jsonDecode(response.body);

    List<SourceModel> sources = [];

    for (var source in decodedData["sources"]) {
      final sourceModel = SourceModel.formJson(source);

      sources.add(sourceModel);
    }

    return sources;
  }

  static Future<List<ArticleModel>> getAllArticles(String sourceID) async {
    final Map<String, dynamic> queryParameters = {
      "apiKey": AppConstants.apiKey,
      "sources": sourceID,
    };
    final response = await http.get(
      Uri.https(AppConstants.baseURL, EndPoints.allArticles, queryParameters),
    );

    final decodedData = jsonDecode(response.body);

    List<ArticleModel> articles = [];

    for (var article in decodedData["articles"]) {
      final articleModel = ArticleModel.fromJson(article);
      articles.add(articleModel);
    }

    return articles;
  }
}
