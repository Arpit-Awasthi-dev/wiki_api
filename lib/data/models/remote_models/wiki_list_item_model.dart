import '../../../domain/entities/wiki_list_item.dart';

class WikiListItemModel extends WikiListItem {
  WikiListItemModel({
    required int index,
    required int pageID,
    required String? thumbnail,
    required String title,
    required String description,
  }) : super(
          index: index,
          pageID: pageID,
          thumbnail: thumbnail,
          title: title,
          description: description,
        );

  factory WikiListItemModel.fromJson(Map<String, dynamic> json) {
    return WikiListItemModel(
      index: json['index'],
      pageID: json['pageid'],
      thumbnail: json['thumbnail'] != null ? json['thumbnail']['source'] : null,
      title: json['title'],
      description: json['terms']['description'][0],
    );
  }
}
