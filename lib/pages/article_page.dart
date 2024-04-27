import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:freo_assignment/providers/article_info_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticlePage extends ConsumerWidget {
  final String articleName;

  const ArticlePage({super.key, required this.articleName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleInfoWatcher = ref.watch(articleInfoProvider(articleName));
    return Scaffold(
      appBar: AppBar(title: Text(articleName)),
      body: articleInfoWatcher.when(
        data: (articleInfo) => SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: HtmlWidget(articleInfo.text),
        ),
        error: (e, s) => Center(child: Text('Error: $e')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
