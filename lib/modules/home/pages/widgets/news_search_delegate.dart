import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/article_card_item.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/article_details.dart';
import 'package:news_app_cycle19_sun/modules/home/viewmodel/view_model_search.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  final ViewModelSearch _viewModel = ViewModelSearch();
  String _query = "";

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  void _onQueryChanged(String query) {
    setState(() => _query = query);
    _viewModel.search(query);
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search news...",
            border: InputBorder.none,
          ),
          onChanged: _onQueryChanged,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              _viewModel.clear();
              setState(() => _query = "");
            },
          ),
        ],
      ),
      body: _query.isEmpty
          ? const Center(child: Text('Search for news articles'))
          : _viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _viewModel.error != null
          ? const Center(child: Text('Something went wrong'))
          : _viewModel.results.isEmpty
          ? const Center(child: Text('No results found'))
          : ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        itemCount: _viewModel.results.length,
        separatorBuilder: (context, index) =>
        const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final article = _viewModel.results[index];
          return Bounce(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>
                    ArticleDetails(article: article),
              );
            },
            child: ArticleCardItem(articleModel: article),
          );
        },
      ),
    );
  }
}