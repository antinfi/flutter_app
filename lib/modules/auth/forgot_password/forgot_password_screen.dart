import '../../../config/config.dart';
import '../../../widgets/app_button.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final controller = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('forgotPassword'.tr)),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(32),
                  AppText.regular('pleaseEnterYouPhoneNumber'.tr, size: 16, color: AppColor.textPrimary.withOpacity(0.8)),
                  const Gap(32),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppTextField.fill(
                          controller.countryCodeTextController,
                          hintText: GlobalVariable.phoneCode,
                          textInputType: TextInputType.phone,
                          enabled: false,
                          validator: (value) {
                            final phone = controller.phoneNumberTextController.text;
                            return phone.isEmpty ? ' ' : null;
                          },
                          onTap: controller.openCountryPicker,
                          align: TextAlign.center,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        flex: 6,
                        child: AppTextField.fill(
                          controller.phoneNumberTextController,
                          hintText: 'yourPhoneNumber'.tr,
                          textInputType: TextInputType.phone,
                          validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'phoneNumber'.tr}) : null,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppButton.send(onTap: controller.onSendTap),
                  // const Gap(kToolbarHeight),
                ],
              ),
            ),
          ),
        ),
      );
}
