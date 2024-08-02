import 'package:bloc_rxdart/src/data/datasources/local/local_storage_service.dart';
import 'package:bloc_rxdart/src/data/datasources/local/secure_storage_service.dart';
import 'package:bloc_rxdart/src/data/datasources/local/shared_preferences_service.dart';
import 'package:bloc_rxdart/src/data/repositories/auth_repository_impl.dart';
import 'package:bloc_rxdart/src/data/repositories/photo_repository_impl.dart';
import 'package:bloc_rxdart/src/data/repositories/post_repository_impl.dart';
import 'package:bloc_rxdart/src/domain/repositories/auth_repository.dart';
import 'package:bloc_rxdart/src/domain/repositories/photo_repository.dart';
import 'package:bloc_rxdart/src/presentation/blocs/photo/photo_bloc.dart';
import 'package:bloc_rxdart/src/presentation/blocs/post/post_bloc.dart';
import 'package:bloc_rxdart/src/utils/network/dio_factory.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/dummy_json_api.dart/dummy_json_api_service.dart';
import '../../data/datasources/post_api_service.dart';
import '../../domain/repositories/post_repository.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';

Future<void> setupDependencies() async {
  final getIt = GetIt.instance;

  //sharedPreferences
  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.init();
  getIt.registerSingleton<LocalStorageService>(sharedPreferencesService);

  // Datasources
  final dio = await DioFactory.getDio();
  getIt.registerLazySingleton(() => PostApiService(dio));

  //API LOGIN
  final dummyApiDio = await DioFactory.getDio(baseUrl: "https://dummyjson.com");
  getIt.registerLazySingleton(() => DummyJsonApiService(dummyApiDio));

  //Đăng kí Repositories
  getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(getIt<PostApiService>()));
  getIt.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(getIt<PostApiService>()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
        getIt<DummyJsonApiService>(), getIt<LocalStorageService>()),
  );

  //Đăng kí Blocs
  getIt.registerFactory(() => PostBloc(getIt<PostRepository>()));
  getIt.registerFactory(() => PhotoBloc(getIt<PhotoRepository>()));
  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>()));
}

//! Sử dụng với một baseUrl khác
  //   final customDio = await DioFactory.getDio(baseUrl: 'https://api.example.com');
  //   final customService = PostApiService(customDio);
  //   final customPosts = await customService.getPosts();