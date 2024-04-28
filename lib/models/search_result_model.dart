class ThumbnailModel {
  final String source;
  final int width;
  final int height;

  ThumbnailModel({
    required this.source,
    required this.width,
    required this.height,
  });

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) {
    return ThumbnailModel(
      source: json['source'],
      width: json['width'],
      height: json['height'],
    );
  }
}

class TermsModel {
  final List<dynamic> label;
  final List<dynamic> description;

  TermsModel({
    required this.label,
    required this.description,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      label: json['label'],
      description: json['description'],
    );
  }
}

class SearchResultModel {
  final int pageId;
  final int ns;
  final String title;
  final int index;
  final ThumbnailModel? thumbnail;
  final String? pageImage;
  final TermsModel? terms;

  SearchResultModel({
    required this.pageId,
    required this.ns,
    required this.title,
    required this.index,
    this.thumbnail,
    this.pageImage,
    this.terms,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      pageId: json['pageid'],
      ns: json['ns'],
      title: json['title'],
      index: json['index'],
      thumbnail: json['thumbnail'] == null
          ? null
          : ThumbnailModel.fromJson(json['thumbnail']),
      pageImage: json['pageimage'],
      terms: json['terms'] == null ? null : TermsModel.fromJson(json['terms']),
    );
  }
}
