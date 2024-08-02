import '../../../config/router/navigation_service.dart';
import '../../../utils/dialog/dialog_service.dart';
import '../../blocs/blocs.dart';

class LoginViewModel {
  final AuthBloc _authBloc;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  LoginViewModel(this._authBloc, this._navigationService, this._dialogService);

  AuthBloc get authBloc => _authBloc;

  void login(String username, String password) {
    _authBloc.add(AuthEvent.login(username, password));
  }

  void handleAuthState(AuthState state) {
    state.when(
      initial: () {},
      loading: () {},
      authenticated: (_) {
        // Sử dụng một micro-task để đảm bảo navigation xảy ra sau khi build hoàn tất
        Future.microtask(() => _navigationService.navigateTo('/home'));
      },
      error: (message) {
        Future.microtask(() => _dialogService.showError(message));
      },
      unauthenticated: () {},
    );
  }

  Stream<AuthState> get authStateStream => _authBloc.stream;
}
