import 'package:bloc_rxdart/src/config/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterNavigationService implements NavigationService {
  final GoRouter _router;

  GoRouterNavigationService(this._router);

  @override
  void navigateTo(String route) {
    // Sử dụng WidgetsBinding để đảm bảo navigation xảy ra sau khi build hoàn tất
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _router.go(route);
    });
  }

  @override
  void pop() {
    if (_router.canPop()) {
      _router.pop();
    }
  }

  @override
  void pushNamed(String name, {Object? arguments}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _router.pushNamed(name, extra: arguments);
    });
  }
}
