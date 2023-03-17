import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_models.dart';

class AppPref {
  final SharedPreferences _preferences;

  AppPref(this._preferences);

  bool get isLogin => _preferences.getBool('isLogin') ?? false;

  set isLogin(bool value) => _preferences.setBool('isLogin', value);

  String get authToken => _preferences.getString('authToken') ?? '';

  set authToken(String value) => _preferences.setString('authToken', value);

  LoginRes? get userData => _preferences.containsKey('userData') ? LoginRes.fromJson(jsonDecode(_preferences.getString('userData')!)) : null;

  set userData(LoginRes? value) => _preferences.setString('userData', jsonEncode(value));

  bool get isBiometricEnable => _preferences.getBool('isBiometricEnable') ?? false;

  set isBiometricEnable(bool value) => _preferences.setBool('isBiometricEnable', value);

  Future<bool> enableBiometric() => _preferences.setBool('isBiometricEnable', true);

  Future<bool> disableBiometric() => _preferences.setBool('isBiometricEnable', false);

  /// clear preference
  Future<void> clear() async {
    final biometric = isBiometricEnable;
    await _preferences.clear();
    isBiometricEnable = biometric;
  }
}
