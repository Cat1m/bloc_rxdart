import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/login/login_view_model.dart';
import '../../presentation/pages/pages.dart';
import 'package:get_it/get_it.dart';

class AppRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(
        viewModel: GetIt.I<LoginViewModel>(),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'posts',
          builder: (context, state) => const PostListPage(),
        ),
        GoRoute(
          path: 'photos',
          builder: (context, state) => const PhotoListPage(),
        ),
        GoRoute(
          path: 'todos',
          builder: (context, state) => const TodosListPage(),
        ),
        GoRoute(
          path: 'combined',
          builder: (context, state) => const CombinedScreen(),
        ),
      ],
    ),
  ];
}
