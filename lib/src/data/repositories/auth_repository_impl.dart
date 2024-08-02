import 'dart:convert';
import 'dart:developer';

import 'package:bloc_rxdart/src/data/datasources/local/local_storage_service.dart';
import 'package:bloc_rxdart/src/domain/models/login/request/login_request.dart';

import 'package:bloc_rxdart/src/domain/models/login/response/user_model.dart';
import 'package:bloc_rxdart/src/utils/constants/storage_keys.dart';
import 'package:bloc_rxdart/src/utils/error/error_handler.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/dummy_json_api.dart/dummy_json_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DummyJsonApiService _dummyJsonApiService;
  final LocalStorageService _localStorage;

  AuthRepositoryImpl(
    this._dummyJsonApiService,
    this._localStorage,
  );

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final loginRequest = LoginRequest(username: username, password: password);
      final user = await _dummyJsonApiService.login(loginRequest);
      await _saveUserToken(user.token);
      await _saveUser(user);
      return user;
    } catch (e) {
      log('Caught error in repository: $e');
      final failure = ErrorHandler.handle(e).failure;
      throw failure;
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = await _localStorage.getString(StorageKeys.user);
      if (userJson != null) {
        return UserModel.fromJson(json.decode(userJson));
      }
      return null;
    } catch (e) {
      log('Caught error in repository: $e');
      final failure = ErrorHandler.handle(e).failure;
      throw failure;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      //kiểm tra token xem có lưu chưa
      final token = await _localStorage.getString(StorageKeys.token);
      return token != null;
    } catch (e) {
      log('Caught error in repository: $e');
      final failure = ErrorHandler.handle(e).failure;
      throw failure;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _localStorage.remove(StorageKeys.token);
      await _localStorage.remove(StorageKeys.user);
      log('đã xóa token vs user');
    } catch (e) {
      //! dùng tạm thôi chứ mình chưa viết trường hợp bắt lỗi cho tụi này
      //! ErrorHandler chỉ đang bắt lỗi cho dio là chính
      log('Caught error in repository: $e');
      final failure = ErrorHandler.handle(e).failure;
      throw failure;
    }
  }

  Future<void> _saveUserToken(String token) async {
    await _localStorage.setString(StorageKeys.token, token);
  }

  Future<void> _saveUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await _localStorage.setString(StorageKeys.user, userJson);
  }
}
