import '../../config/config.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('contactUs'.tr)),
        body: SizedBox.expand(
          child: Column(
            children: [
              const Gap(32),
              AppText.semiBold('workingHours'.tr, size: 18, color: AppColor.black),
              const Gap(12),
              AppText.regular('workingHoursTiming'.tr, size: 16, textAlign: TextAlign.center),
              const Gap(24),
              _ItemWidget('chatWithUs'.tr, Assets.icons.chatWithUs.path, () {}),
              const Divider(height: 0),
              _ItemWidget('ourSupportLine'.tr, Assets.icons.ourSupportLine.path, () {}),
              const Divider(height: 0),
              _ItemWidget('instagram'.tr, Assets.icons.instagram.path, () {}),
              const Divider(height: 0),
              _ItemWidget('whatsapp'.tr, Assets.icons.whatsapp.path, () {}),
              const Divider(height: 0),
              _ItemWidget('sendUsAnEmail'.tr, Assets.icons.sendUsMail.path, () {}),
              const Divider(height: 0),
              _ItemWidget('facebook'.tr, Assets.icons.facebook.path, () {}),
              const Divider(height: 0),
              _ItemWidget('line'.tr, Assets.icons.line.path, () {}),
              const Divider(height: 0),
              const Gap(24),
              const Spacer(),
              AppText.regular('reachOutToUsAnytimeWereHereForYou'.tr),
              const Gap(8),
              AppText.regular('faq'.tr, color: AppColor.primary, isUnderline: true),
              const Gap(kToolbarHeight),
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
            ],
          ),
        ),
      );
}
