import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _localAuth;

  BiometricAuth(this._localAuth);

  var availableBiometrics = <BiometricType>[];

  Future<bool> get canCheckBiometrics => _localAuth.canCheckBiometrics;

  Future<bool> isFaceIdEnable() async {
    if (Platform.isIOS) {
      await getAvailableBiometrics();
      return availableBiometrics.contains(BiometricType.face) || availableBiometrics.contains(BiometricType.strong);
    }
    return false;
  }

  Future<bool> isFingerprintEnable() async {
    await getAvailableBiometrics();
    return availableBiometrics.contains(BiometricType.fingerprint) || availableBiometrics.contains(BiometricType.strong);
  }

  Future getAvailableBiometrics() async {
    if (availableBiometrics.isEmpty) {
      availableBiometrics = await _localAuth.getAvailableBiometrics();
      debugPrint('BiometricAuth.getAvailableBiometrics: $availableBiometrics');
    }
  }

  Future<void> doBiometricAuthentication(String message, {VoidCallback? onAuthenticate, Function(PlatformException? error)? onUnAuthenticate}) async {
    final canCheckBiometrics = await _localAuth.canCheckBiometrics;
    debugPrint('BiometricAuth.doBiometricAuthentication: canCheckBiometrics: $canCheckBiometrics');
    if (canCheckBiometrics) {
      try {
        final didAuthenticate = await _localAuth.authenticate(localizedReason: message);
        debugPrint('BiometricAuth.doBiometricAuthentication: didAuthenticate: $didAuthenticate');
        if (didAuthenticate) {
          onAuthenticate?.call();
        } else {
          onUnAuthenticate?.call(null);
        }
      } on PlatformException catch (exc) {
        debugPrint('BiometricAuth.doBiometricAuthentication: PlatformException $exc');
        onUnAuthenticate?.call(exc);
      } on Exception catch (exc) {
        debugPrint('BiometricAuth.doBiometricAuthentication: Exception $exc');
        onUnAuthenticate?.call(null);
      }
    } else {
      onUnAuthenticate?.call(null);
    }
  }
}
