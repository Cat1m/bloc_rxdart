part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  //! chỗ này tạo mấy cái sự kiện để quản lí đăng nhập như là đi khách sạn
  //! check in cần thông tin
  //! check out thì xóa thông tin thôi nên không cần tham số
  //! check xem trạng thái vd như còn ở hay không
  const factory AuthEvent.login(String username, String password) = _Login;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.checkAuthStatus() = _CheckAuthStatus;
}
