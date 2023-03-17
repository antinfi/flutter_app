import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/config.dart';
import '../../../widgets/app_button.dart';
import 'mobile_verification_controller.dart';

class MobileVerificationScreen extends StatelessWidget {
  MobileVerificationScreen({Key? key}) : super(key: key);

  final controller = Get.find<MobileVerificationController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 16),
          child: AppBar(
            title: Text(
              "Enter the code we've just\nsent to your phone\n${controller.phoneNumber}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Gap(44),
              AppText.medium('verificationCode'.tr),
              const Gap(22),
              PinCodeTextField(
                controller: controller.otpController,
                length: 6,
                appContext: context,
                animationType: AnimationType.scale,
                animationDuration: const Duration(milliseconds: 300),
                onChanged: (value) => controller.isOtpValid.value = value.length == 6,
                onCompleted: (value) => controller.verifyOtp(),
                keyboardType: TextInputType.number,
                cursorColor: AppColor.textPrimary,
                textStyle: AppTextStyle.pinCodeText,
                hintStyle: AppTextStyle.pinCodeHint,
                hintCharacter: '',
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                useHapticFeedback: true,
                hapticFeedbackTypes: HapticFeedbackTypes.medium,
                enableActiveFill: true,
                pinTheme: PinTheme(
                  borderRadius: BorderRadius.circular(14),
                  fieldHeight: 64,
                  borderWidth: 1,
                  fieldOuterPadding: EdgeInsets.zero,
                  shape: PinCodeFieldShape.box,
                  selectedColor: AppColor.pinBorder,
                  selectedFillColor: AppColor.white,
                  activeColor: AppColor.pinBorder,
                  activeFillColor: AppColor.white,
                  inactiveFillColor: AppColor.white,
                  disabledColor: AppColor.pinBorder,
                  inactiveColor: AppColor.pinBorder,
                  errorBorderColor: AppColor.error,
                ),
              ),
              const Gap(22),
              Row(
                children: [
                  const Gap(24),
                  Expanded(child: Obx(() => AppButton.resendCode(onTap: controller.resendCode, remainTime: controller.remainTime.value))),
                  const Gap(24),
                ],
              ),
              const Gap(12),
              // AppText.medium('Just two try left!', color: AppColor.textPrimary.withOpacity(0.77)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.medium('${'wrongNumber'.tr} '),
                  GestureDetector(
                    onTap: Get.back,
                    child: AppText.regular('edit'.tr, color: AppColor.primary, isUnderline: true),
                  ),
                  AppText.medium(' ${'or'.tr} '),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.contactUs),
                    child: AppText.regular('contactOurSupport'.tr, color: AppColor.primary, isUnderline: true),
                  ),
                ],
              ),
              Gap(context.navigationBarHeight + 16),
            ],
          ),
        ),
      );
}
