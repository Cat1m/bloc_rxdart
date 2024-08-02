import 'package:bloc_rxdart/src/utils/encryption/encryption_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> getString(String key) async {
    final encryptedValue = await _secureStorage.read(key: key);
    return encryptedValue != null
        ? EncryptionService.decrypt(encryptedValue)
        : null;
  }

  @override
  Future<void> setString(String key, String value) async {
    final encryptedValue = EncryptionService.encrypt(value);
    await _secureStorage.write(key: key, value: encryptedValue);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<bool?> getBool(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : null;
  }

  @override
  Future<int?> getInt(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
