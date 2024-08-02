import 'package:bloc_rxdart/src/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/router/navigation_service.dart';
import '../../config/router/navigation_service_impl.dart';
import '../../utils/dialog/dialog_service.dart';
import '../../utils/dialog/flutter_dialog_service.dart';

class AppServices {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: AppRoutes.routes,
  );

  static final NavigationService navigationService =
      GoRouterNavigationService(router);
  static final DialogService dialogService = FlutterDialogService(navigatorKey);
}
