import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.when(
          initial: () => {},
          loading: () => {
            const Center(
              child: CircularProgressIndicator(),
            )
          },
          authenticated: (_) {
            context.go('/home');
          },
          unauthenticated: () {
            context.go('/login');
          },
          error: (message) {
            log('Error: $message');
            context.go('/login');
          },
        );
      },
      child: const Scaffold(
        body: Center(
          child: FlutterLogo(size: 100),
        ),
      ),
    );
  }
}
