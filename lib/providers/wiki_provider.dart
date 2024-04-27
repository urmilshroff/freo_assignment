import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freo_assignment/models/wiki_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final wikiProvider = Provider((ref) => WikiManager(ref));

class WikiManager {
  final ProviderRef ref;

  WikiManager(this.ref);

  Future<List<SearchResultModel>> getSearchResults(String query) async {
    final api = 'https://en.wikipedia.org/w/api.php?';

    try {
      final response = await Dio().get(
        api,
        queryParameters: {
          'action': 'query',
          'origin': '*',
          'format': 'json',
          'generator': 'search',
          'gsrnamespace': 0,
          'gsrlimit': 5,
          'gsrsearch': query,
        },
      );

      final Map<String, dynamic> searchResultsJson =
          response.data['query']['pages'];

      final searchResultsList = List.generate(
        searchResultsJson.length,
        (i) => SearchResultModel.fromJson(
          searchResultsJson.values.elementAt(i),
        ),
      );

      return searchResultsList;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
}
