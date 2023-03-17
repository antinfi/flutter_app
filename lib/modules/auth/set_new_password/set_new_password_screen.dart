import '../../../config/config.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/password_validator_widget.dart';
import 'set_new_password_controller.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({Key? key}) : super(key: key);

  final controller = Get.find<SetNewPasswordController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('setANewPassword'.tr)),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                const Gap(32),
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
                AppTextField.fill(
                  controller.identityNumberTextController,
                  hintText: 'identityNumber'.tr,
                  textInputAction: TextInputAction.done,
                  validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': ''.tr}) : null,
                ),
                const Gap(20),
                const Spacer(),
                AppButton.done(onTap: controller.onDone),
                Gap(context.navigationBarHeight + 16),
              ],
            ),
          ),
        ),
      );
}
