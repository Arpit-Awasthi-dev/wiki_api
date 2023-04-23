import 'package:test_wiki_assign/data/models/local_models/local_wiki_item.dart';

import '../../../core/db/database_helper.dart';

abstract class WikiLocalDataSource {
  Future<List<LocalWikiItem>> getLocalWikiList(String query);

  Future<void> storeWikiList(List<LocalWikiItem> list);

  Future<void> storeWikiDetail(int pageID, String detail);

  Future<String?> getWikiDetail(int pageID);
}

class WikiLocalDataSourceImpl implements WikiLocalDataSource {
  final DatabaseHelper db;

  WikiLocalDataSourceImpl({required this.db});

  @override
  Future<void> storeWikiList(List<LocalWikiItem> list) async {
    return await db.storeWikiList(list);
  }

  @override
  Future<List<LocalWikiItem>> getLocalWikiList(String query) async {
    final response = await db.queryWikiList(query);
    return response;
  }

  @override
  Future<void> storeWikiDetail(int pageID, String detail) async {
    return await db.storeWikiDetail(pageID, detail);
  }

  @override
  Future<String?> getWikiDetail(int pageID) async {
    final response = await db.getWikiDetail(pageID);
    return response;
  }

}
