import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_wiki_assign/data/data_sources/local/wiki_local_data_source.dart';
import 'package:test_wiki_assign/data/data_sources/remote/wiki_remote_data_source.dart';
import 'package:test_wiki_assign/data/repositories/wiki_repo_impl.dart';
import 'package:test_wiki_assign/domain/repository/wiki_repo.dart';
import 'package:test_wiki_assign/domain/usecases/get_wiki_list_use_case.dart';
import 'package:test_wiki_assign/presentation/cubits/wiki_detail_page/wiki_detail_page_cubit.dart';
import 'package:test_wiki_assign/presentation/cubits/wiki_list_page/wiki_list_page_cubit.dart';

import '../domain/usecases/get_wiki_detail_use_case.dart';
import 'app_config.dart';
import 'db/database_helper.dart';
import 'navigation/navigation_service.dart';
import 'network/api_service.dart';
import 'network/network_info.dart';

//Service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  /// ---------- Cubits ------------
  sl.registerFactory(() => WikiListPageCubit(getWikiListUseCase: sl()));
  sl.registerFactory(() => WikiDetailPageCubit(getWikiDetailUseCase: sl()));

  /// ----------- Use Cases ----------
  sl.registerLazySingleton(() => GetWikiListUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetWikiDetailUseCase(repository: sl()));

  /// ----------- Repositories -----------
  sl.registerLazySingleton<WikiRepo>(
    () => WikiRepoImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  /// ----------- Data Sources ----------
  sl.registerLazySingleton<WikiRemoteDataSource>(
    () => WikiRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<WikiLocalDataSource>(
    () => WikiLocalDataSourceImpl(db: sl()),
  );

  /// ------------ Others -------------
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => DatabaseHelper.instance);

  /// ---------- Network ------------
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(
    () => ApiService(
      baseUrl: AppConfig.instance!.apiBaseURL,
      client: sl.get(instanceName: 'api'),
    ),
  );

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(
      () => InterceptedClient.build(
            interceptors: [],
            requestTimeout: const Duration(seconds: 10),
          ),
      instanceName: 'api');

  final addresses = [
    AddressCheckOptions(hostname: 'google.com', port: 80),
    AddressCheckOptions(
      address: InternetAddress(
        '208.67.222.222', // Cisco Umbrella
        type: InternetAddressType.IPv4,
      ),
    ),
    ...InternetConnectionChecker.DEFAULT_ADDRESSES.map(
      (AddressCheckOptions e) => AddressCheckOptions(
        address: e.address,
        hostname: e.hostname,
        port: e.port,
        timeout: InternetConnectionChecker.DEFAULT_TIMEOUT,
      ),
    ),
  ];

  sl.registerLazySingleton(
      () => InternetConnectionChecker.createInstance(addresses: addresses));
}
