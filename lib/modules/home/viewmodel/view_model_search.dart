import 'package:flutter/widgets.dart';
import 'package:news_app_cycle19_sun/core/network/http_requests_service.dart';
import 'package:news_app_cycle19_sun/models/article_model.dart';

class ViewModelSearch extends ChangeNotifier {
  List<ArticleModel> results = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  String? error;
  int page = 1;
  String query = '';


  Future<void> search(String value) async {
    if (value.trim().isEmpty) return;

    query = value.trim();
    page = 1;
    results = [];
    error = null;
    isLoading = true;
    notifyListeners();

    try {
      results = await HttpRequestsService.searchArticles(
        query,
        page,
      );
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  } Future<void> loadMore() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      page++;

      final newArticles =
      await HttpRequestsService.searchArticles(query, page);

      results.addAll(newArticles);
    } catch (e) {
      page--;
      error = e.toString();
    }

    isLoadingMore = false;
    notifyListeners();
  }
  void clear() {
    results = [];
    query = '';
    page = 1;
    error = null;
    notifyListeners();
  }
}