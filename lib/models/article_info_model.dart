class ArticleInfoModel {
  final int pageId;
  final String title;
  final String text;

  ArticleInfoModel({
    required this.pageId,
    required this.title,
    required this.text,
  });

  factory ArticleInfoModel.fromJson(Map<String, dynamic> json) {
    return ArticleInfoModel(
      pageId: json['pageid'],
      title: json['title'],
      text: json['text'],
    );
  }
}
