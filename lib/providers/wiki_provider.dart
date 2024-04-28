import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freo_assignment/models/search_result_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final wikiProvider = Provider((ref) => WikiManager(ref));

class WikiManager {
  final ProviderRef ref;

  WikiManager(this.ref);

  Future<List<SearchResultModel>> getSearchResults(String query) async {
    final api = 'https://en.wikipedia.org/w/api.php?';

    try {
      final response = await Dio().getUri(
        Uri.parse(api).resolveUri(
          Uri(
            queryParameters: {
              'action': 'query',
              'origin': '*',
              'format': 'json',
              'formatversion': '2',
              'generator': 'search',
              'gsrnamespace': '0',
              'gsrlimit': '10',
              'gsrsearch': query,
              'prop': ['pageimages|pageterms'],
            },
          ),
        ),
      );

      final List<dynamic> searchResultsJson = response.data['query']['pages'];

      final searchResultsList = List.generate(
        searchResultsJson.length,
        (i) => SearchResultModel.fromJson(searchResultsJson[i]),
      );

      return searchResultsList;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
}
