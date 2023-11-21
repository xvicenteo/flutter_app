import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static final SecureStorageService _instance = SecureStorageService._internal();

  factory SecureStorageService() {
    return _instance;
  }

  SecureStorageService._internal();

  // Functions

  Future<void> writeToken(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readToken(String key) async {
    return await _storage.read(key: key);
  }

}