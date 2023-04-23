import 'package:dartz/dartz.dart';
import 'package:test_wiki_assign/core/base_usecase/failure.dart';
import 'package:test_wiki_assign/core/network/api_service.dart';
import 'package:test_wiki_assign/data/models/local_models/local_wiki_item.dart';
import 'package:test_wiki_assign/domain/entities/wiki_list_item.dart';
import 'package:test_wiki_assign/domain/repository/wiki_repo.dart';
import 'package:test_wiki_assign/domain/usecases/get_wiki_detail_use_case.dart';
import 'package:test_wiki_assign/domain/usecases/get_wiki_list_use_case.dart';

import '../../core/network/network_info.dart';
import '../data_sources/local/wiki_local_data_source.dart';
import '../data_sources/remote/wiki_remote_data_source.dart';

class WikiRepoImpl implements WikiRepo {
  final NetworkInfo networkInfo;
  final WikiRemoteDataSource remoteDataSource;
  final WikiLocalDataSource localDataSource;

  WikiRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<WikiListItem>>> getWikiList(
      GetWikiListParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getWikiList(params);

        var localWikiList = response
            .map((e) => LocalWikiItem(
                  pageID: e.pageID,
                  thumbnail: e.thumbnail,
                  title: e.title,
                  description: e.description,
                  detail: null,
                ))
            .toList();

        localDataSource.storeWikiList(localWikiList);

        return Right(response);
      } on ApiException catch (ex) {
        return Left(ApiFailure(ex.message));
      }
    } else {
      var localResponse = await localDataSource.getLocalWikiList(params.query);

      if (localResponse.isNotEmpty) {
        List<WikiListItem> response = localResponse
            .map((e) => WikiListItem(
                  index: 0,
                  pageID: e.pageID,
                  thumbnail: e.thumbnail,
                  title: e.title,
                  description: e.description,
                ))
            .toList();

        return Right(response);
      } else {
        return Left(InternetFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> getWikiDetail(
      GetWikiDetailParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getWikiDetail(params);
        localDataSource.storeWikiDetail(params.pageID, response);

        return Right(response);
      } on ApiException catch (ex) {
        return Left(ApiFailure(ex.message));
      }
    } else {
      var detail = await localDataSource.getWikiDetail(params.pageID);
      if (detail != null) {
        return Right(detail);
      } else {
        return Left(InternetFailure());
      }
    }
  }
}
