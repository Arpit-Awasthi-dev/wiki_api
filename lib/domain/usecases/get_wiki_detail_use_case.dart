import 'package:dartz/dartz.dart';
import 'package:test_wiki_assign/core/base_usecase/failure.dart';
import 'package:test_wiki_assign/core/base_usecase/usecase.dart';
import 'package:test_wiki_assign/domain/repository/wiki_repo.dart';

class GetWikiDetailUseCase implements UseCase<String, GetWikiDetailParams> {
  final WikiRepo repository;

  GetWikiDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(GetWikiDetailParams params) async {
    return await repository.getWikiDetail(params);
  }
}

class GetWikiDetailParams {
  /// required in db operations
  final int pageID;

  /// required in api call
  final String title;

  // predefined
  final String _action = 'query';
  final String _format = 'json';
  final String _prop = 'extracts';
  final int _formatVersion = 2;
  final int _exSentences = 10;
  final int _exLimit = 1;
  final int _explainText = 1;

  GetWikiDetailParams({required this.pageID, required this.title});

  Map<String, String> toMap() {
    final map = <String, String>{};

    map['titles'] = title;

    // predefined
    map['action'] = _action;
    map['format'] = _format;
    map['prop'] = _prop;
    map['formatversion'] = _formatVersion.toString();
    map['exsentences'] = _exSentences.toString();
    map['exlimit'] = _exLimit.toString();
    map['explaintext'] = _explainText.toString();

    return map;
  }
}
