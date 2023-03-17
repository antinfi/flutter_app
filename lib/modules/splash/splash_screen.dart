import '../../config/config.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(child: Assets.icons.elipticLogoBackground.svg()),
                GetBuilder<SplashController>(
                  builder: (controller) => Center(
                    child: Assets.icons.worldcomFinance.svg(
                      width: controller.animationValue * Get.width * .93,
                      height: controller.animationValue * Get.height * .13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(30),
          AppText.bold(
            'splashScreenMessage'.tr,
            size: 20,
            color: AppColor.black,
          ),
          const Spacer(flex: 2),
        ]),
      );
}
