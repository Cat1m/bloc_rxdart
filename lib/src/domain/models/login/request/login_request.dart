import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

@freezed
abstract class LoginRequest with _$LoginRequest {
  factory LoginRequest({
    required String username,
    required String password,
    @Default(30) int expiresInMins,
  }) = _LoginRequest;
  factory LoginRequest.fromJson(Map<String, Object> json) =>
      _$LoginRequestFromJson(json);
}
