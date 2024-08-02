import 'package:bloc_rxdart/src/data/datasources/local/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

//? throw UnimplementedError() là cách thông báo rằng phương thức hiện tại chưa được thực hiện và sẽ gây lỗi nếu được gọi.

class SharedPreferencesService implements LocalStorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  //! gọi hàm này là pentakill thấy là quét sạch
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
