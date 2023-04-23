class WikiListItem {

  /// using for sorting
  final int index;
  final int pageID;
  final String? thumbnail;
  final String title;
  final String description;

  WikiListItem({
    required this.index,
    required this.pageID,
    required this.thumbnail,
    required this.title,
    required this.description,
  });
}
