import 'package:flutter/widgets.dart';
import 'package:news_app_cycle19_sun/core/network/http_requests_service.dart';
import 'package:news_app_cycle19_sun/models/article_model.dart';

class ViewModelArticle extends ChangeNotifier{
  List<ArticleModel> articles=[];
  bool isLoading=false;
  String? error;
  Future<void> getAllArticles(String sourceID) async {
    try{
      isLoading = true;
      error = null;
      notifyListeners();
      articles=await HttpRequestsService.getAllArticles(sourceID);
    }catch(e){
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}