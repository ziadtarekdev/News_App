import 'package:flutter/widgets.dart';
import 'package:news_app_cycle19_sun/core/network/http_requests_service.dart';
import 'package:news_app_cycle19_sun/models/source_model.dart';

class SourceViewModel extends ChangeNotifier {
  List<SourceModel> sourcesList = [];
  String? errorMessage;
  bool isLoading = false;

    Future<void> getSources(String categoryId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      sourcesList =
      await HttpRequestsService.getAllSources(categoryId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}