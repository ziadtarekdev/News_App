import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/core/network/http_requests_service.dart';
import 'package:news_app_cycle19_sun/models/category_model.dart';
import 'package:news_app_cycle19_sun/models/source_model.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/article_card_item.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/tab_bar_item.dart';

class SelectedCategoryView extends StatefulWidget {
  final CategoryModel selectedCategoryModel;

  const SelectedCategoryView({super.key, required this.selectedCategoryModel});

  @override
  State<SelectedCategoryView> createState() => _SelectedCategoryViewState();
}

class _SelectedCategoryViewState extends State<SelectedCategoryView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SourceModel>>(
      future: HttpRequestsService.getAllSources(
        widget.selectedCategoryModel.id,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        final sourcesList = snapshot.data ?? [];

        return Column(
          spacing: 16,
          children: [
            DefaultTabController(
              length: sourcesList.length,
              child: TabBar(
                isScrollable: true,
                dividerHeight: 0,
                indicatorColor: Colors.black,
                labelPadding: EdgeInsets.symmetric(horizontal: 14),
                tabAlignment: TabAlignment.start,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                tabs: sourcesList
                    .map(
                      (source) => TabBarItem(
                        sourceModel: source,
                        isSelected:
                            sourcesList.indexOf(source) == selectedIndex,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: HttpRequestsService.getAllArticles(
                  sourcesList[selectedIndex].id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  final articles = snapshot.data ?? [];

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return ArticleCardItem(articleModel: articles[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
