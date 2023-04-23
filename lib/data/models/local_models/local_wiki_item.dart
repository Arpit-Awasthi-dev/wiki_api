import '../../../core/db/tables/wiki_table.dart';

class LocalWikiItem {
  final int pageID;
  final String title;
  final String description;
  final String? thumbnail;
  String? detail;

  LocalWikiItem({
    required this.pageID,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.detail,
  });

  Map<String, dynamic> toJson() => {
        WikiTable().columnPageID: pageID,
        WikiTable().columnTitle: title,
        WikiTable().columnDescription: description,
        WikiTable().columnDetail: detail,
        WikiTable().columnThumbnail: thumbnail,
      };

  factory LocalWikiItem.fromJson(Map<String, dynamic> json) => LocalWikiItem(
        pageID: json[WikiTable().columnPageID],
        thumbnail: json[WikiTable().columnThumbnail],
        title: json[WikiTable().columnTitle],
        description: json[WikiTable().columnDescription],
        detail: json[WikiTable().columnDetail],
      );
}
