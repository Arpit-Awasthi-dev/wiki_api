import 'package:dartz/dartz.dart';
import 'package:test_wiki_assign/domain/entities/wiki_list_item.dart';

import '../../core/base_usecase/failure.dart';
import '../usecases/get_wiki_detail_use_case.dart';
import '../usecases/get_wiki_list_use_case.dart';

abstract class WikiRepo {
  Future<Either<Failure, List<WikiListItem>>> getWikiList(
    GetWikiListParams params,
  );

  Future<Either<Failure, String>> getWikiDetail(
    GetWikiDetailParams params,
  );
}
