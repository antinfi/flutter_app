import '../../../../config/config.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/password_validator_widget.dart';
import 'account_information_controller.dart';

class AccountInformationScreen extends StatelessWidget {
  AccountInformationScreen({Key? key}) : super(key: key);

  final controller = Get.find<AccountInformationController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('accountInformation'.tr)),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
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
                const Gap(20),
                AppTextField.fill(
                  controller.emailTextController,
                  hintText: '${'email'.tr}*',
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) return 'pleaseEnterYour'.trParams({'info': 'email'.tr});
                    if (!email.isEmail) return 'invalid'.tr;
                    return null;
                  },
                ),
                const Gap(20),
                Obx(() => AppTextField.fill(
                      controller.passwordTextController,
                      hintText: '${'password'.tr}*',
                      obscure: !controller.isPasswordVisible.value,
                      textInputType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: controller.isPasswordVisible.toggle,
                        icon: Assets.icons.eyeHide.svg(),
                      ),
                      validator: (value) {
                        if (value.isNullOrEmpty) return 'pleaseEnterYour'.trParams({'info': 'password'.tr});
                        final isValid = PasswordUtil.isValid(value);
                        return isValid ? null : 'invalid'.tr;
                      },
                    )),
                const Gap(4),
                Obx(() => PasswordValidatorWidget(controller.passwordText.value)),
                const Gap(20),
                Obx(() => AppTextField.fill(
                      controller.confirmPasswordTextController,
                      hintText: '${'confirmPassword'.tr}*',
                      obscure: !controller.isConfirmPasswordVisible.value,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        onPressed: controller.isConfirmPasswordVisible.toggle,
                        icon: Assets.icons.eyeHide.svg(),
                      ),
                      validator: (value) {
                        if (value.isNullOrEmpty) return 'pleaseEnterYour'.trParams({'info': 'confirmPassword'.tr});
                        if (controller.passwordTextController.text != value) return 'passwordDoNotMatch'.tr;
                        return null;
                      },
                    )),
                const Gap(20),
                GestureDetector(
                  onTap: controller.changeTermsCheck,
                  child: Row(
                    children: [
                      const Icon(Icons.check_box, color: AppColor.primary),
                      const Gap(12),
                      AppText.regular('${'iAgreeWithThe'.tr} '),
                      GestureDetector(
                        onTap: controller.openTerms,
                        child: AppText.regular('termsOfUse'.tr, isUnderline: true, color: AppColor.primary),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                AppButton.next(onTap: controller.onNext),
                const Gap(24),
              ],
            ),
          ),
        ),
      );
}
