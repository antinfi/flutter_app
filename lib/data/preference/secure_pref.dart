import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePref {
  final FlutterSecureStorage _storage;

  SecurePref(this._storage);

  Future<String> getEmail() async => (await _storage.read(key: 'email')) ?? '';

  Future<void> setEmail(String value) => _storage.write(key: 'email', value: value);

  Future<String> getCountryCode() async => (await _storage.read(key: 'countryCode')) ?? '';

  Future<void> setCountryCode(String value) => _storage.write(key: 'countryCode', value: value);

  Future<String> getPhone() async => (await _storage.read(key: 'phone')) ?? '';

  Future<void> setPhone(String value) => _storage.write(key: 'phone', value: value);

  Future<String> getPassword() async => (await _storage.read(key: 'pw')) ?? '';

  Future<void> setPassword(String value) => _storage.write(key: 'pw', value: value);

  Future<bool> hasCredentials() => _storage.containsKey(key: 'pw');

  /// clear preference
  Future<void> clear() => _storage.deleteAll();
}
