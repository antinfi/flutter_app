import 'package:country_picker/country_picker.dart';

import '../../../config/config.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final countryCodeTextController = TextEditingController(text: GlobalVariable.phoneCode);
  final phoneNumberTextController = TextEditingController();

  void openCountryPicker() {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      onSelect: (country) => countryCodeTextController.text = '+${country.phoneCode}',
    );
  }

  void onSendTap() {
    Get.toNamed(AppRoute.setNewPassword);

    // if (!(formKey.currentState?.validate() ?? false)) return;
    //
    // hideKeyboard();
  }
}
