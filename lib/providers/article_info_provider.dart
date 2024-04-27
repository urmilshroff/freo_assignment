import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freo_assignment/models/article_info_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final articleInfoProvider = FutureProvider.family<ArticleInfoModel, String>((
  ref,
  articleName,
) async {
  final api = 'https://en.wikipedia.org/w/api.php?';
  try {
    final response = await Dio().get(
      api,
      queryParameters: {
        'action': 'parse',
        'origin': '*',
        'format': 'json',
        'page': articleName,
        'prop': 'text',
        'formatversion': 2,
      },
    );

    final articleInfoModel = ArticleInfoModel.fromJson(response.data['parse']);

    return articleInfoModel;
  } on DioException catch (e) {
    debugPrint(e.toString());
    throw e;
  }
});
