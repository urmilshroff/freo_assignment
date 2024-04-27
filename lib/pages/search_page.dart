import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:freo_assignment/pages/article_page.dart';
import 'package:freo_assignment/providers/wiki_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('WikiSearch'),
        debounceDuration: Duration(seconds: 1),
        onSearch: (query) => debugPrint(query),
        asyncSuggestions: (query) async {
          final searchResults =
              await ref.read(wikiProvider).getSearchResults(query);
          final searchResultsTitles = List.generate(
              searchResults.length, (i) => searchResults[i].title);
          return searchResultsTitles;
        },
        onSuggestionTap: (articleName) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(articleName: articleName),
          ),
        ),
      ),
    );
  }
}
