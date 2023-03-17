import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/connectivity_helper.dart';
import 'base/message_helper.dart';
import 'data/auth/biometric_auth.dart';
import 'data/network/network_module.dart';
import 'data/preference/app_pref.dart';
import 'data/preference/secure_pref.dart';

/// init all dependencies
Future<void> initDependencies() async {
  Get
    ..put(AppPref(await SharedPreferences.getInstance()), permanent: true)
    ..put(ConnectivityHelper(), permanent: true)
    ..put(MessageHelper(), permanent: true)

    // lazy
    ..lazyPut<SecurePref>(
      () {
        const storage = FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );
        return SecurePref(storage);
      },
      fenix: true,
    )
    ..lazyPut(() => BiometricAuth(LocalAuthentication()), fenix: true)
    ..lazyPut(NetworkModule.prepareDio, fenix: true)
    ..lazyPut(NetworkModule.getApiClient, fenix: true)
    ..lazyPut(NetworkModule.getAuthClient, fenix: true);
}
