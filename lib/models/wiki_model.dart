class SearchResultModel {
  final int pageId;
  final int ns;
  final String title;
  final int index;

  SearchResultModel({
    required this.pageId,
    required this.ns,
    required this.title,
    required this.index,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      pageId: json['pageid'],
      ns: json['ns'],
      title: json['title'],
      index: json['index'],
    );
  }
}
