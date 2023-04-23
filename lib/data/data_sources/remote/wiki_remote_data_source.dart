import 'package:test_wiki_assign/domain/entities/wiki_list_item.dart';

import '../../../core/network/api_service.dart';
import '../../../domain/usecases/get_wiki_detail_use_case.dart';
import '../../../domain/usecases/get_wiki_list_use_case.dart';
import '../../models/remote_models/wiki_list_item_model.dart';

abstract class WikiRemoteDataSource {
  Future<List<WikiListItem>> getWikiList(GetWikiListParams params);

  Future<String> getWikiDetail(GetWikiDetailParams params);
}

class WikiRemoteDataSourceImpl implements WikiRemoteDataSource {
  final ApiService client;

  WikiRemoteDataSourceImpl({required this.client});

  @override
  Future<List<WikiListItem>> getWikiList(GetWikiListParams params) async {
    final response =
        await client.get('/w/api.php', queryParams: params.toMap());

    final list = (response['query']['pages'] as List)
        .map((e) => WikiListItemModel.fromJson(e))
        .toList();

    /// sort acc to index to show results purposefully
    list.sort((a, b) => a.index.compareTo(b.index));

    return list;
  }

  @override
  Future<String> getWikiDetail(GetWikiDetailParams params) async {
    final response =
        await client.get('/w/api.php', queryParams: params.toMap());

    return response['query']['pages'][0]['extract'];
  }
}
