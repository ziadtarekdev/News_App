import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/article_card_item.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/article_details.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/button.dart';
import 'package:news_app_cycle19_sun/modules/home/viewmodel/view_model_search.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController controller = TextEditingController();
  final ViewModelSearch viewModel = ViewModelSearch();

  Future<void> search() async {
    if (controller.text.trim().isEmpty) return;

    setState(() {});

    await viewModel.search(controller.text.trim());

    setState(() {});
  }

  Future<void> loadMore() async {
    setState(() {});
    await viewModel.loadMore();
    setState(() {});
  }

  void clearSearch() {
    controller.clear();
    viewModel.clear();
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: 'Search news...',
            border: InputBorder.none,
          ),
          onSubmitted: (_) => search(),
        ),
        actions: [
          IconButton(onPressed: search, icon: const Icon(Icons.search)),
          IconButton(onPressed: clearSearch, icon: const Icon(Icons.clear)),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null && viewModel.results.isEmpty) {
      return const Center(child: Text('Something went wrong'));
    }

    if (viewModel.results.isEmpty) {
      return const Center(child: Text('Search for news articles'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),

      itemCount: viewModel.results.length + 1,

      separatorBuilder: (context, index) => SizedBox(height: 16),

      itemBuilder: (context, index) {
        if (index == viewModel.results.length) {
          return viewModel.isLoadingMore
              ? const Center(child: CircularProgressIndicator())
              : Button(text: "Load More", onPressed: () => loadMore());
        }

        final article = viewModel.results[index];

        return Bounce(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return ArticleDetails(article: article);
              },
            );
          },
          child: ArticleCardItem(articleModel: article),
        );
      },
    );
  }
}
