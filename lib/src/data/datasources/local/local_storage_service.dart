abstract class LocalStorageService {
  //setup for string(chuỗi)
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  //setup for bool(true,false)
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  //setup for int(số)
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  //xóa theo key
  Future<void> remove(String key);
  //cho đăng xuất hết
  Future<void> clear();
}
