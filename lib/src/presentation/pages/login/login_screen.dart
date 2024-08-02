import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_rxdart/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:bloc_rxdart/src/presentation/pages/login/loading_overlay.dart';
import 'package:bloc_rxdart/src/presentation/pages/login/login_form.dart';
import 'package:bloc_rxdart/src/presentation/pages/login/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginScreen({super.key, required this.viewModel});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.viewModel.authBloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          widget.viewModel.handleAuthState(state);
          setState(() {
            _isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
          });
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(title: const Text('Login')),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: LoginForm(
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                    onSubmit: _onLoginSubmit,
                    isLoading: _isLoading,
                  ),
                ),
              ),
              if (_isLoading) const Positioned.fill(child: LoadingOverlay()),
            ],
          );
        },
      ),
    );
  }

  void _onLoginSubmit() {
    widget.viewModel.login(
      _usernameController.text,
      _passwordController.text,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
