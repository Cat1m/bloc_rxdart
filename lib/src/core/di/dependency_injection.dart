import 'package:bloc_rxdart/src/config/router/navigation_service.dart';
import 'package:bloc_rxdart/src/data/datasources/remote/movie_api.dart/movie_api.dart';
import 'package:bloc_rxdart/src/data/repositories/album_repository_imple.dart';
import 'package:bloc_rxdart/src/data/repositories/comment_repository_impl.dart';
import 'package:bloc_rxdart/src/data/repositories/movie_repository_imple.dart';
import 'package:bloc_rxdart/src/data/repositories/todos_repository_impl.dart';
import 'package:bloc_rxdart/src/data/repositories/user_repository_impl.dart';
import 'package:bloc_rxdart/src/domain/repositories/album_repository.dart';
import 'package:bloc_rxdart/src/domain/repositories/comment_repository.dart';
import 'package:bloc_rxdart/src/domain/repositories/movie_repository.dart';
import 'package:bloc_rxdart/src/domain/repositories/todos_repository.dart';
import 'package:bloc_rxdart/src/domain/repositories/user_repository.dart';
import 'package:bloc_rxdart/src/presentation/blocs/combined/combined_bloc.dart';
import 'package:bloc_rxdart/src/presentation/blocs/movie/movie_bloc.dart';
import 'package:bloc_rxdart/src/presentation/blocs/todos/todos_bloc.dart';
import 'package:bloc_rxdart/src/presentation/blocs/user/user_bloc.dart';
import 'package:bloc_rxdart/src/utils/network/dio_factory.dart';
import 'package:get_it/get_it.dart';
import '../../config/router/app_service.dart';
import '../../data/datasources/local/local.dart';
import '../../data/datasources/remote/remote.dart';
import '../../data/repositories/repositories_impl.dart';
import '../../domain/repositories/repositories.dart';
import '../../presentation/blocs/blocs.dart';
import '../../presentation/pages/login/login_view_model.dart';
import '../../utils/dialog/dialog_service.dart';

Future<void> setupDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<NavigationService>(
      () => AppServices.navigationService);
  getIt.registerLazySingleton<DialogService>(() => AppServices.dialogService);

  //viewmodel
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
        getIt<AuthBloc>(),
        getIt<NavigationService>(),
        getIt<DialogService>(),
      ));

  //sharedPreferences
  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.init();
  getIt.registerSingleton<LocalStorageService>(sharedPreferencesService);

  // Datasources
  final dio = await DioFactory.getDio();
  getIt.registerLazySingleton(() => JsonPlaceHolderApiService(dio));

  //API LOGIN
  final dummyApiDio = await DioFactory.getDio(baseUrl: "https://dummyjson.com");
  getIt.registerLazySingleton(() => DummyJsonApiService(dummyApiDio));

  //API MOVIE
  final movieApiDio =
      await DioFactory.getDio(baseUrl: "https://www.episodate.com");
  getIt.registerLazySingleton(() => MovieApi(movieApiDio));

  //Đăng kí Repositories
  getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(getIt<JsonPlaceHolderApiService>()));
  getIt.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(getIt<JsonPlaceHolderApiService>()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
        getIt<DummyJsonApiService>(), getIt<LocalStorageService>()),
  );

  getIt.registerLazySingleton<TodosRepository>(
      () => TodosRepositoryImpl(getIt<JsonPlaceHolderApiService>()));

  getIt.registerLazySingleton<AlbumRepository>(
      () => AlbumRepositoryImple(getIt<JsonPlaceHolderApiService>()));
  getIt.registerLazySingleton<CommentRepository>(
      () => CommentRepositoryImpl(getIt<JsonPlaceHolderApiService>()));
  // user
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(getIt<JsonPlaceHolderApiService>()));

  //Movies
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImple(getIt<MovieApi>()));

  //Đăng kí Blocs
  getIt.registerFactory(() => PostBloc(getIt<PostRepository>()));
  getIt.registerFactory(() => PhotoBloc(getIt<PhotoRepository>()));
  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>()));
  getIt.registerFactory(() => TodosBloc(getIt<TodosRepository>()));
  getIt.registerFactory(() => CombinedBloc(
        getIt<AlbumRepository>(),
        getIt<CommentRepository>(),
        getIt<PostRepository>(),
        getIt<UserRepository>(),
        getIt<PhotoRepository>(),
      ));
  getIt.registerFactory(() => UserBloc(getIt<UserRepository>()));

  //movieBloc
  getIt.registerFactory(
      () => MovieBloc(movieRepository: getIt<MovieRepository>()));
}

//! Sử dụng với một baseUrl khác
  //   final customDio = await DioFactory.getDio(baseUrl: 'https://api.example.com');
  //   final customService = PostApiService(customDio);
  //   final customPosts = await customService.getPosts();