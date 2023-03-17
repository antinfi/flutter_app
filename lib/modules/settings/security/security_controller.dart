import '../../../config/config.dart';
import '../../../data/auth/biometric_auth.dart';

class SecurityController extends BaseController {
  final biometricAuth = Get.find<BiometricAuth>();
  final hasFaceId = false.obs;
  final hasFingerprint = false.obs;

  final isBiometricEnable = false.obs;

  @override
  void onInit() {
    super.onInit();

    biometricAuth.isFaceIdEnable().then((value) => hasFaceId.value = value);
    biometricAuth.isFingerprintEnable().then((value) => hasFingerprint.value = value);

    isBiometricEnable.value = appPref.isBiometricEnable;
  }

  void setupFaceId() {
    if (isBiometricEnable.value) {
      isBiometricEnable.value = false;
      appPref.disableBiometric();
      return;
    }
    biometricAuth.doBiometricAuthentication(
      'Please authenticate to setup FaceID for login',
      onAuthenticate: () {
        isBiometricEnable.value = true;
        appPref.enableBiometric();
        showSuccess('FaceID setup complete.');
      },
      onUnAuthenticate: (error) => openWarningDialog(error?.message ?? ''),
    );
  }

  void setupFingerPrint() {
    debugPrint('SecurityController.setupFingerPrint: ${isBiometricEnable.value}');
    if (isBiometricEnable.value) {
      isBiometricEnable.value = false;
      appPref.disableBiometric();
      return;
    }
    biometricAuth.doBiometricAuthentication(
      'Hold your finger down to scan.',
      onAuthenticate: () {
        isBiometricEnable.value = true;
        appPref.enableBiometric();
        showSuccess('Fingerprint setup complete.');
      },
      onUnAuthenticate: (error) => openWarningDialog(error?.message ?? ''),
    );
  }
}
