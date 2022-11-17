import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ny_times_api_test_flutter/core/network/network_info.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/datasources/article_local_data_source_impl.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/datasources/article_remote_data_source_impl.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/data/reposetories/article_repository_impl.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_local_data_source.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_remode_data_source.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_repository.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/usecases/get_articles.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  // Use cases
  sl.registerFactory(() => GetArticles(repository: sl()));

  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
      remoteData: sl(), localData: sl(), networkInfo: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourseImpl(client: sl()));
  sl.registerLazySingleton<ArticleLocalDataSource>(() => ArticleLocalDataSourseImpl(secureStorage: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => const FlutterSecureStorage());



}
