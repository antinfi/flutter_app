import 'package:country_picker/country_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/config.dart';
import '../../../../data/model/auth_models.dart';

class AccountInformationController extends BaseController {
  final formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final countryCodeTextController = TextEditingController(text: GlobalVariable.phoneCode);
  final phoneNumberTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final passwordText = ''.obs;

  IdentityRes? identityRes;

  @override
  void onInit() {
    super.onInit();
    (Get.arguments as IdentityRes?)?.let((self) => identityRes = self);

    passwordTextController.addListener(() => passwordText.value = passwordTextController.text.trim());
  }

  void openCountryPicker() {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      onSelect: (country) => countryCodeTextController.text = '+${country.phoneCode}',
    );
  }

  void changeTermsCheck() {
    openWarningDialog('warningCheckTerms'.tr);
  }

  void openTerms() {
    launchUrl(Uri.parse('https://worldcomfinance.com/terms-and-conditions'), mode: LaunchMode.externalApplication);
  }

  void onNext() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    hideKeyboard();

    final phoneNumber = '${countryCodeTextController.text.trim()}${phoneNumberTextController.text.trim()}';

    final map = {
      'identityId': identityRes?.identity?.id,
      'identityCode': identityRes?.identity?.code,
      'email': emailTextController.text.trim(),
      'phone': phoneNumber,
      'deviceId': GlobalVariable.deviceId,
      'password': passwordTextController.text.trim(),
      'passwordConfirmation': confirmPasswordTextController.text.trim(),
    };

    callApi(authClient.signup(map)).then((value) {
      if (value != null) {
        appPref.authToken = value.token ?? '';
        Get.toNamed(AppRoute.mobileVerification, arguments: phoneNumber);
      }
    });
  }
}
