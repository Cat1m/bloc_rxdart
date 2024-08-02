import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/models/login/response/user_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(const AuthState.initial()) {
    on<AuthEvent>(
      (event, emit) async {
        await event.when(
          login: (username, password) => _onLogin(username, password, emit),
          logout: () => _onLogout(emit),
          checkAuthStatus: () => _onCheckAuthStatus(emit),
        );
      },
    );
  }

  Future<void> _onLogin(
      String username, String password, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.login(username, password);
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> _onLogout(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    try {
      await _authRepository.logout();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(AuthState.authenticated(user));
        } else {
          emit(const AuthState.unauthenticated());
        }
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }
}
