import 'package:bloc_rxdart/src/presentation/pages/photo/photo_list_page.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/home/home_screen.dart';
import '../../presentation/pages/login/login_screen.dart';
import '../../presentation/pages/post/post_list_page.dart';
import '../../presentation/pages/splash/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
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
        ],
      ),
    ],
  );
}
