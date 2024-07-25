import 'package:bloc_rxdart/src/data/repositories/photo_repository_impl.dart';
import 'package:bloc_rxdart/src/domain/repositories/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'src/config/router/app_router.dart';
import 'src/config/themes/app_theme.dart';
import 'src/domain/repositories/photo_repository.dart';
import 'src/presentation/blocs/photo/photo_bloc.dart';
import 'src/presentation/blocs/post/post_bloc.dart';
import 'src/data/repositories/post_repository_impl.dart';
import 'src/data/datasources/post_api_service.dart';
import 'src/utils/network/dio_factory.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

Future<void> setupDependencies() async {
  final getIt = GetIt.instance;

  // Sử dụng với một baseUrl khác
  //   final customDio = await DioFactory.getDio(baseUrl: 'https://api.example.com');
  //   final customService = PostApiService(customDio);
  //   final customPosts = await customService.getPosts();

  // Datasources
  final dio = await DioFactory.getDio();
  getIt.registerLazySingleton(() => PostApiService(dio));

  // Repositories
  getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(getIt<PostApiService>()));
  getIt.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(getIt<PostApiService>()));

  // Blocs
  getIt.registerFactory(() => PostBloc(getIt<PostRepository>()));
  getIt.registerFactory(() => PhotoBloc(getIt<PhotoRepository>()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
