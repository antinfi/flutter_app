import '../../../config/config.dart';
import 'security_controller.dart';

class SecurityScreen extends StatelessWidget {
  SecurityScreen({Key? key}) : super(key: key);

  final controller = Get.find<SecurityController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('security'.tr)),
        body: SizedBox.expand(
          child: Obx(() => Column(
                children: [
                  const Gap(32),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                      child: Row(
                        children: [
                          Assets.icons.changePassword.svg(),
                          const Gap(16),
                          AppText.regular('changePassword'.tr, color: AppColor.textPrimary),
                          const Spacer(),
                          Assets.icons.arrowNext.svg(),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0),
                  if (controller.hasFaceId.value) ...[
                    _ItemWidget(
                      'addFaceId'.tr,
                      Assets.icons.addFaceId.path,
                      controller.isBiometricEnable,
                      controller.setupFaceId,
                    ),
                    const Divider(height: 0),
                  ],
                  if (controller.hasFingerprint.value) ...[
                    _ItemWidget(
                      'addFingerprint'.tr,
                      Assets.icons.addFingerprint.path,
                      controller.isBiometricEnable,
                      controller.setupFingerPrint,
                    ),
                    const Divider(height: 0),
                  ],
                ],
              )),
        ),
      );
}

class _ItemWidget extends StatelessWidget {
  final String title;
  final String path;
  final RxBool switchValue;
  final GestureTapCallback onTap;

  const _ItemWidget(this.title, this.path, this.switchValue, this.onTap, {Key? key}) : super(key: key);

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
              Obx(() => Switch.adaptive(
                    value: switchValue.value,
                    onChanged: (value) => onTap(),
                  )),
            ],
          ),
        ),
      );
}
