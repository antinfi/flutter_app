import '../../../config/config.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/app_button.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: OurAppBar.logIn(),
      body: Column(
        children: [
          const Gap(8),
          TabBar(
            controller: controller.tabController,
            labelColor: AppColor.primary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            unselectedLabelColor: AppColor.unselectedLabel,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            indicatorColor: AppColor.primary,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.5, color: AppColor.primary),
              insets: EdgeInsets.only(left: 15, right: 15, bottom: 8),
            ),
            tabs: [
              Tab(text: 'email'.tr),
              Tab(text: 'phoneNumber'.tr),
            ],
            onTap: controller.onTabChange,
          ),
          Expanded(
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    const Gap(32),
                    Obx(() {
                      if (controller.tabIndex.value == 0) {
                        return AppTextField.fill(
                          controller.emailTextController,
                          hintText: 'email'.tr,
                          textInputType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) return 'pleaseEnterYour'.trParams({'info': 'email'.tr});
                            if (!email.isEmail) return 'invalid'.tr;
                            return null;
                          },
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppTextField.fill(
                              controller.countryCodeTextController,
                              hintText: GlobalVariable.phoneCode,
                              textInputType: TextInputType.phone,
                              enabled: false,
                              validator: (value) {
                                final phone = controller.phoneNumberTextController.text.trim();
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
                      );
                    }),
                    const Gap(16),
                    Obx(() => AppTextField.fill(
                          controller.passwordTextController,
                          hintText: 'password'.tr,
                          textInputAction: TextInputAction.done,
                          obscure: !controller.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            onPressed: controller.isPasswordVisible.toggle,
                            icon: Assets.icons.eyeHide.svg(),
                          ),
                          validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'password'.tr}) : null,
                        )),
                    const Gap(8),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoute.forgotPassword),
                          child: AppText.medium('${'forgotPassword'.tr}?', size: 12, color: AppColor.primary, isUnderline: true),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Obx(() {
                      if (controller.isFaceIdEnable.value || controller.isFingerprintEnable.value) {
                        return GestureDetector(
                          onTap: controller.doBiometricAuthentication,
                          child: controller.isFaceIdEnable.value
                              ? Assets.icons.faceId.svg()
                              : Column(
                                  children: [
                                    Assets.icons.fingerprint.svg(),
                                    const Gap(24),
                                    AppText.medium('holdYourFingerDownToScan'.tr),
                                  ],
                                ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    const Spacer(),
                    AppButton.logIn(onTap: controller.onLoginTap),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.medium('${'notAMember'.tr} ', size: 15),
                        GestureDetector(
                          child: AppText.medium('registerFree'.tr, size: 15, color: AppColor.primary, isUnderline: true),
                          onTap: () => Get.toNamed(AppRoute.identificationDocument),
                        ),
                      ],
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.contactUs),
                      child: AppText.medium(
                        'contactCustomerService'.tr,
                        size: 15,
                        isUnderline: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                    const Gap(24),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
}
