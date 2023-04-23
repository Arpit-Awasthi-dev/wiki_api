import 'package:dartz/dartz.dart';
import 'package:test_wiki_assign/domain/entities/wiki_list_item.dart';

import '../../core/base_usecase/failure.dart';
import '../../core/base_usecase/usecase.dart';
import '../repository/wiki_repo.dart';

class GetWikiListUseCase implements UseCase<List<WikiListItem>, GetWikiListParams> {
  final WikiRepo repository;

  GetWikiListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<WikiListItem>>> call(GetWikiListParams params) async {
    return await repository.getWikiList(params);
  }
}

class GetWikiListParams {
  /// to be requested
  final String query;

  /// predefined
  final String _action = 'query';
  final String _format = 'json';
  final String _prop = 'pageimages|pageterms';
  final String _generator = 'prefixsearch';
  final int _redirects = 1;
  final int _formatVersion = 2;
  final String _piProp = 'thumbnail';
  final int _piThumbSize = 50;
  final int _piLimit = 5;
  final String _wbPtTerms = 'description';
  final int _gpsLimit = 10;

  GetWikiListParams({required this.query});

  Map<String, String> toMap() {
    var map = <String, String>{};

    /// to be requested
    map['gpssearch'] = query;

    /// predefined
    map['action'] = _action;
    map['format'] = _format;
    map['prop'] = _prop;
    map['generator'] = _generator;
    map['redirects'] = _redirects.toString();
    map['formatversion'] = _formatVersion.toString();
    map['piprop'] = _piProp;
    map['pithumbsize'] = _piThumbSize.toString();
    map['pilimit'] = _piLimit.toString();
    map['wbptterms'] = _wbPtTerms;
    map['gpslimit'] = _gpsLimit.toString();

    return map;
  }
}
