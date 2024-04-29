import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:freo_assignment/providers/article_info_provider.dart';
import 'package:freo_assignment/providers/wiki_provider.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends HookConsumerWidget {
  final String articleName;
  final wikiLink = 'https://en.wikipedia.org/wiki/';

  const ArticlePage({super.key, required this.articleName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleInfoWatcher = ref.watch(articleInfoProvider(articleName));

    useEffect(() {
      unawaited(ref.read(wikiProvider).cacheWikiArticle(articleName));
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(articleName),
        actions: [
          IconButton(
            onPressed: () async {
              if (!await launchUrl(Uri.parse(wikiLink + articleName))) {
                throw Exception();
              }
            },
            icon: Icon(Icons.open_in_browser_rounded),
          ),
        ],
      ),
      body: articleInfoWatcher.when(
        data: (articleInfo) => SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: HtmlWidget(articleInfo.text!),
        ),
        error: (e, s) {
          final wikiBox = Hive.box(name: 'wikiBox');
          final articleInfoModel = wikiBox.get(articleName);

          Future.microtask(() => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Error fetching article, displaying cached version'),
                ),
              ));

          return SingleChildScrollView(
            padding: EdgeInsets.all(8.0),
            child:
                Text(articleInfoModel?['wikiText'] ?? 'Error loading article!'),
          );
        },
        loading: () => Center(
          child: Image.asset(
            'assets/animations/loading.gif',
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }
}
