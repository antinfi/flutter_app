import '../../../config/config.dart';

class SetNewPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final identityNumberTextController = TextEditingController();

  final passwordText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    passwordTextController.addListener(() => passwordText.value = passwordTextController.text.trim());
  }

  void onDone() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    hideKeyboard();
  }
}
