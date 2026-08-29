import 'package:flutter/widgets.dart';
import 'package:news_app_cycle19_sun/core/network/http_requests_service.dart';
import 'package:news_app_cycle19_sun/models/article_model.dart';

class ViewModelSearch extends ChangeNotifier {
  List<ArticleModel> results = [];
  bool isLoading = false;
  String? error;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      results = [];
      error = null;
      notifyListeners();
      return;
    }
    try {
      isLoading = true;
      error = null;
      notifyListeners();
      results = await HttpRequestsService.searchArticles(query);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    results = [];
    error = null;
    notifyListeners();
  }
}