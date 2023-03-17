import '../../config/config.dart';
import '../../widgets/app_button.dart';

class SettingsController extends BaseController {
  final headers = <String, String>{};
  var userAvatar = '';

  @override
  void onInit() {
    userAvatar = 'https://picsum.photos/200';
    headers['Authorization'] = appPref.authToken;
    super.onInit();
  }

  void onLogout() {
    Get.dialog<bool>(_LogoutDialog()).then((value) async {
      if (value != null && value) {
        await appPref.clear();
        await Get.offAllNamed(AppRoute.login);
      }
    });
  }
}

class _LogoutDialog extends StatelessWidget {
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
              Assets.icons.logout.svg(),
              const Gap(24),
              Row(
                children: [
                  const Gap(24),
                  Expanded(
                      child: AppText.medium(
                    'areYouSureYouWantToLogout'.tr,
                    size: 16,
                    textAlign: TextAlign.center,
                    color: AppColor.textPrimary,
                  )),
                  const Gap(24),
                ],
              ),
              const Gap(40),
              Row(children: [
                const Gap(24),
                Expanded(
                  child: AppButton.yes(onTap: () => Get.back(result: true)),
                ),
                const Gap(16),
                Expanded(
                  child: AppButton.no(onTap: Get.back),
                ),
                const Gap(24),
              ]),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
}
