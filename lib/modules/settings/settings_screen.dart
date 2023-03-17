import '../../config/config.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('settings'.tr),
          actions: [
            GestureDetector(
              onTap: controller.onLogout,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.logoutBtnBG,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: AppText.medium('logOut'.tr, size: 12, color: AppColor.logoutBtn),
                ),
              ),
            ),
            const Gap(16),
          ],
        ),
        body: SizedBox.expand(
          child: Column(
            children: [
              const Gap(32),
              Stack(
                children: [
                  Container(
                    width: 123,
                    height: 123,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.dropShadow,
                          blurRadius: 22,
                          offset: Offset(0, 4),
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(backgroundImage: NetworkImage(controller.userAvatar, headers: controller.headers)),
                  ),
                  PositionedDirectional(
                    width: 25,
                    height: 25,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Assets.icons.editDetails.svg(),
                    ),
                  ),
                ],
              ),
              const Gap(24),
              _ItemWidget('editingPersonalDetails'.tr, Assets.icons.editDetails.path, () {}), //Get.toNamed(AppRoute.myAccount)
              const Divider(height: 0),
              _ItemWidget('security'.tr, Assets.icons.security.path, () => Get.toNamed(AppRoute.security)),
              const Divider(height: 0),
              _ItemWidget('contactUs'.tr, Assets.icons.contactUs.path, () => Get.toNamed(AppRoute.contactUs)),
              const Divider(height: 0),
              _ItemWidget('aboutWorldcom'.tr, Assets.icons.about.path, () {}),
              const Divider(height: 0),
            ],
          ),
        ),
      );
}

class _ItemWidget extends StatelessWidget {
  final String title;
  final String path;
  final GestureTapCallback onTap;

  const _ItemWidget(this.title, this.path, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          child: Row(
            children: [
              SvgPicture.asset(path),
              const Gap(16),
              AppText.regular(title, color: AppColor.textPrimary),
              const Spacer(),
              Assets.icons.arrowNext.svg(),
            ],
          ),
        ),
      );
}
