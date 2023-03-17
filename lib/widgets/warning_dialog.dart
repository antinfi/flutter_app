import '../config/config.dart';

void openContactCustomerServiceDialog(String message) {
  Get.dialog(
    WarningDialog(
      message,
      moreWidgets: [
        GestureDetector(
          onTap: () => Get.offNamed(AppRoute.contactUs),
          child: AppText.regular(
            'contactCustomerService'.tr,
            color: AppColor.primary,
            isUnderline: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ],
    ),
  );
}

void openWarningDialog(String message) {
  if (message.isNotEmpty) Get.dialog(WarningDialog(message));
}

class WarningDialog extends StatelessWidget {
  final String message;
  final List<Widget>? moreWidgets;

  const WarningDialog(this.message, {this.moreWidgets, super.key});

  @override
  Widget build(BuildContext context) => Material(
        color: AppColor.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsetsDirectional.all(44),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: IconButton(onPressed: Get.back, icon: Assets.icons.close.svg()),
                ),
                Assets.icons.warning.svg(),
                const Gap(24),
                Row(
                  children: [
                    const Gap(24),
                    Expanded(child: AppText.medium(message, size: 16, textAlign: TextAlign.center)),
                    const Gap(24),
                  ],
                ),
                if (!moreWidgets.isNullOrEmpty) ...{
                  const Gap(24),
                  ...moreWidgets!,
                },
                const Gap(24),
              ],
            ),
          ),
        ),
      );
}
