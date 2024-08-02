import '../models/login/response/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String username, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserModel?> getCurrentUser();
}
