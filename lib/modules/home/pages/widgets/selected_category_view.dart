import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/core/network/http_requests_service.dart';
import 'package:news_app_cycle19_sun/models/category_model.dart';
import 'package:news_app_cycle19_sun/models/source_model.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/article_card_item.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/article_details.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/tab_bar_item.dart';
import 'package:news_app_cycle19_sun/modules/home/viewmodel/view_model_article.dart';
import 'package:news_app_cycle19_sun/modules/home/viewmodel/view_model_sources.dart';
import 'package:provider/provider.dart';
import 'package:sheet/route.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              SourceViewModel()..getSources(widget.selectedCategoryModel.id),
        ),
        ChangeNotifierProvider(create: (_) => ViewModelArticle()),
      ],
      child: Consumer<SourceViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage == 'error') {
            return const Center(child: Text('Something went wrong'));
          } else if (viewModel.sourcesList.isEmpty) {
            return const Center(child: Text('Something went wrong'));
          } else {
            final sourcesList = viewModel.sourcesList;
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
                      selectedIndex = value;
                      setState(() {});
                      context.read<ViewModelArticle>().getAllArticles(
                        sourcesList[selectedIndex].id,
                      );
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

                Consumer<ViewModelArticle>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.error == 'error') {
                      return const Center(child: Text('Something went wrong'));
                    } else if (viewModel.articles.isEmpty) {
                      return const Center(child: Text('Something went wrong'));
                    } else {
                      final articles = viewModel.articles;
                      return Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return Bounce(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ArticleDetails(article: articles[index]),
                                );
                              },
                              child: ArticleCardItem(
                                articleModel: articles[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
