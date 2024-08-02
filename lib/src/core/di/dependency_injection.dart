import 'package:bloc_rxdart/src/utils/network/dio_factory.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/local/local.dart';
import '../../data/datasources/remote/remote.dart';
import '../../data/repositories/repositories_impl.dart';
import '../../domain/repositories/repositories.dart';
import '../../presentation/blocs/blocs.dart';

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