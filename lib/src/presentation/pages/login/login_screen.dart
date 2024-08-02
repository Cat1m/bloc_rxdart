import 'package:bloc_rxdart/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              authenticated: (_) => context.go('/home'),
              error: (message) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              ),
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  state.maybeWhen(
                    orElse: () => ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthEvent.login(
                            _usernameController.text,
                            _passwordController.text));
                      },
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
