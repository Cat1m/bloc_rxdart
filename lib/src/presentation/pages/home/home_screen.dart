import 'package:bloc_rxdart/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          unauthenticated: () => context.go('/login'),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                actions: [
                  TextButton(
                    onPressed: state.maybeWhen(
                      loading: () => null,
                      orElse: () => () => _handleLogout(context),
                    ),
                    child: const Text("Đăng xuất"),
                  )
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/home/posts'),
                      child: const Text('View Posts'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/home/photos'),
                      child: const Text('View Photos'),
                    ),
                  ],
                ),
              ),
            ),
            if (state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            ))
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEvent.logout());
  }
}
