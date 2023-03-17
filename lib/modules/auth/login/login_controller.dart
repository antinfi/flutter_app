import 'package:country_picker/country_picker.dart';

import '../../../config/config.dart';
import '../../../data/auth/biometric_auth.dart';

class LoginController extends BaseController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final tabIndex = 0.obs;
  final formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final countryCodeTextController = TextEditingController(text: GlobalVariable.phoneCode);
  final phoneNumberTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final isPasswordVisible = false.obs;

  final biometricAuth = Get.find<BiometricAuth>();
  final isFaceIdEnable = false.obs;
  final isFingerprintEnable = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    securePref.hasCredentials().then((value) {
      if (value && appPref.isBiometricEnable) {
        biometricAuth.isFaceIdEnable().then((value) {
          isFaceIdEnable.value = value;
          biometricAuth.isFingerprintEnable().then((value) {
            isFingerprintEnable.value = value;
          });
        });
      }
    });
  }

  void onTabChange(int value) {
    formKey.currentState?.reset();
    tabIndex.value = value;
  }

  void doBiometricAuthentication() {
    biometricAuth.doBiometricAuthentication(
      isFingerprintEnable.value ? 'Hold your finger down to scan.' : 'Please authenticate to login',
      onAuthenticate: () {
        Future.wait([
          securePref.getEmail(),
          securePref.getCountryCode(),
          securePref.getPhone(),
          securePref.getPassword(),
        ]).then((values) {
          if ((values[0].isNotEmpty || values[1].isNotEmpty || values[2].isNotEmpty) && values[3].isNotEmpty) {
            _callLoginApi(
              email: values[0],
              countryCode: values[1],
              phone: values[2],
              password: values[3],
            );
          }
        });
      },
      onUnAuthenticate: (error) => openWarningDialog(error?.message ?? ''),
    );
  }

  void openCountryPicker() {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      onSelect: (country) => countryCodeTextController.text = '+${country.phoneCode}',
    );
  }

  void onLoginTap() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    hideKeyboard();

    _callLoginApi(
      email: emailTextController.text.trim(),
      countryCode: countryCodeTextController.text.trim(),
      phone: phoneNumberTextController.text.trim(),
      password: passwordTextController.text.trim(),
    );
  }

  void _callLoginApi({
    required String email,
    required String countryCode,
    required String phone,
    required String password,
  }) {
    final map = {
      if (email.isNotEmpty) 'email': email,
      if (phone.isNotEmpty) 'phone': '$countryCode$phone',
      'password': password,
      // 'version': appVersion,
      // 'deviceName': deviceName,
    };

    callApi(email.isNotEmpty ? authClient.loginByEmail(map) : authClient.loginByPhone(map)).then((value) {
      if (value != null) {
        appPref
          ..authToken = value.token ?? ''
          ..isLogin = true
          ..userData = value;

        securePref.clear().then((value) {
          if (email.isNotEmpty) {
            securePref.setEmail(email);
          } else {
            securePref
              ..setCountryCode(countryCode)
              ..setPhone(phone);
          }
          securePref.setPassword(password);

          Get.offAllNamed(AppRoute.home);
        });
      }
    });
  }
}
