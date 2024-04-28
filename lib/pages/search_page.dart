import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:freo_assignment/pages/article_page.dart';
import 'package:freo_assignment/providers/wiki_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  final wikiLogo =
      'https://upload.wikimedia.org/wikipedia/commons/8/80/Wikipedia-logo-v2.svg';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('WikiSearch'),
        searchHintText: 'Start typing for suggestions',
        debounceDuration: Duration(seconds: 1),
        onSearch: (query) => debugPrint(query),
        asyncSuggestions: (query) async {
          if (query.isNotEmpty) {
            final searchResults =
                await ref.read(wikiProvider).getSearchResults(query);
            return searchResults;
          } else {
            return [];
          }
        },
        suggestionToString: (searchResult) => searchResult.title,
        onSuggestionTap: (searchResult) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(articleName: searchResult.title),
          ),
        ),
        suggestionBuilder: (searchResult) => ListTile(
          dense: true,
          title: Text(searchResult.title),
          subtitle: Text(
            searchResult.terms?.description.first ?? 'No description available',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox.fromSize(
              size: Size.fromRadius(28),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: searchResult.thumbnail?.source ?? wikiLogo,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.search_rounded,
                ),
              ),
            ),
          ),
        ),
        suggestionLoaderBuilder: () => Image.asset(
          'assets/animations/loading.gif',
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
