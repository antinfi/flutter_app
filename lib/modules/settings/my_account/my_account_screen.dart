import '../../../config/config.dart';
import 'my_account_controller.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({Key? key}) : super(key: key);

  final controller = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('myAccount'.tr)),
        body: SizedBox.expand(
          child: Column(
            children: [
              const Gap(32),
              Assets.icons.personalCamera.svg(),
              const Gap(32),
              _ItemWidget('personalInformation'.tr, Assets.icons.personalInfo.path, () {}),
              const Divider(height: 0),
              _ItemWidget('myReceivers'.tr, Assets.icons.myReceivers.path, () {}),
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
