class ArticleInfoModel {
  final int pageId;
  final String title;
  final String? text;
  final String? wikiText;

  ArticleInfoModel({
    required this.pageId,
    required this.title,
    this.text,
    this.wikiText,
  });

  factory ArticleInfoModel.fromJson(Map<String, dynamic> json) {
    return ArticleInfoModel(
      pageId: json['pageid'],
      title: json['title'],
      text: json['text'], // html should always exist in the cached object
      wikiText: json['wikitext'], // regular plaintext
    );
  }

  Map<String, dynamic> toJson() => {
        'pageid': pageId,
        'title': title,
        'text': text,
        'wikitext': wikiText,
      };
}
