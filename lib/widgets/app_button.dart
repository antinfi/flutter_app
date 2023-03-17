import '../config/config.dart';

abstract class AppButton extends StatelessWidget {
  /// Large filled buttons
  factory AppButton.logIn({VoidCallback? onTap}) => _AppFilledButton(title: 'logIn'.tr, onTap: onTap);

  factory AppButton.next({VoidCallback? onTap}) => _AppFilledButton(title: 'next'.tr, onTap: onTap, boldText: true);

  factory AppButton.send({VoidCallback? onTap}) => _AppFilledButton(title: 'send'.tr, onTap: onTap);

  factory AppButton.done({VoidCallback? onTap}) => _AppFilledButton(title: 'done'.tr, onTap: onTap);

  factory AppButton.save({VoidCallback? onTap}) => _AppFilledButton(title: 'save'.tr, onTap: onTap);

  factory AppButton.select({VoidCallback? onTap}) => _AppFilledButton(title: 'select'.tr, onTap: onTap);

  factory AppButton.submit({VoidCallback? onTap}) => _AppFilledButton(title: 'submit'.tr, onTap: onTap);

  factory AppButton.payNow({VoidCallback? onTap}) => _AppFilledButton(title: 'payNow'.tr, onTap: onTap);

  factory AppButton.inviteFriends({VoidCallback? onTap}) => _AppFilledButton(title: 'inviteFriends'.tr, onTap: onTap);

  factory AppButton.changePassword({VoidCallback? onTap}) => _AppFilledButton(title: 'changePassword'.tr, onTap: onTap);

  factory AppButton.addNewReceiver({VoidCallback? onTap}) => _AppFilledButton(title: 'addNewReceiver'.tr, onTap: onTap);

  factory AppButton.settings({VoidCallback? onTap}) => _AppFilledButton(title: 'settings'.tr, onTap: onTap);

  /// Large outlined buttons
  factory AppButton.uploadIDPicture({VoidCallback? onTap}) => _AppLargeOutlinedButton(
        title: 'uploadDocumentPicture'.tr,
        prefixIcon: Assets.icons.worldGlobe.path,
        onTap: onTap,
      );

  factory AppButton.resendCode({VoidCallback? onTap, String? remainTime}) => _AppLargeOutlinedButton(
        title: remainTime.isNullOrEmpty ? 'resendCode'.tr : '${'resendCode'.tr} $remainTime',
        onTap: onTap,
      );

  factory AppButton.documentPicture({VoidCallback? onTap, bool alreadyUploaded = false}) => _AppLargeOutlinedButton(
        title: alreadyUploaded ? 'uploadAnotherDocumentPicture'.tr : 'uploadADocumentPicture'.tr,
        prefixIcon: Assets.icons.camera.path,
        onTap: onTap,
      );

  /// Small text buttons
  factory AppButton.forgotPassword({VoidCallback? onTap}) => _AppTextButton(
        title: 'forgotPassword'.tr,
        onTap: onTap,
      );

  factory AppButton.registerFree({VoidCallback? onTap}) => _AppTextButton(
        title: 'registerFree'.tr,
        onTap: onTap,
      );

  factory AppButton.contactCustomerService({VoidCallback? onTap}) => _AppTextButton(
        title: 'contactCustomerService'.tr,
        onTap: onTap,
        underline: false,
      );

  // ignore: non_constant_identifier_names
  factory AppButton.FAQ({VoidCallback? onTap}) => _AppTextButton(
        title: 'faq'.tr,
        onTap: onTap,
      );

  /// Icon buttons
  factory AppButton.globe({VoidCallback? onTap}) => //
      _AppIconButton(icon: Assets.icons.worldGlobe.path, onTap: onTap);

  factory AppButton.more({VoidCallback? onTap}) => //
      _AppIconButton(icon: Assets.icons.more.path, onTap: onTap);

  /// Small black rounded buttons
  factory AppButton.cancel({VoidCallback? onTap}) => //
      _AppBlackRoundedButton(title: 'cancel'.tr, filled: false, height: 35.48, onTap: onTap);

  factory AppButton.confirm({VoidCallback? onTap}) => //
      _AppBlackRoundedButton(title: 'confirm'.tr, filled: true, height: 35.48, onTap: onTap);

  factory AppButton.idCard({VoidCallback? onTap, bool filled = false}) => //
      _AppBlackRoundedButton(title: 'idCard'.tr, filled: filled, onTap: onTap);

  factory AppButton.passport({VoidCallback? onTap, bool filled = false}) => //
      _AppBlackRoundedButton(title: 'passport'.tr, filled: filled, onTap: onTap);

  factory AppButton.male({VoidCallback? onTap, bool filled = false}) => //
      _AppBlackRoundedButton(icon: Assets.icons.male.path, filled: filled, onTap: onTap);

  factory AppButton.female({VoidCallback? onTap, bool filled = false}) => //
      _AppBlackRoundedButton(icon: Assets.icons.female.path, filled: filled, onTap: onTap);

  factory AppButton.yes({VoidCallback? onTap}) => //
      _AppBlackRoundedButton(title: 'yes'.tr, filled: false, height: 35.48, onTap: onTap);

  factory AppButton.no({VoidCallback? onTap}) => //
      _AppBlackRoundedButton(title: 'no'.tr, filled: true, height: 35.48, onTap: onTap);
}

class _AppFilledButton extends StatelessWidget implements AppButton {
  const _AppFilledButton({
    required this.title,
    this.onTap,
    this.boldText = false,
  });

  final VoidCallback? onTap;
  final String title;
  final bool boldText;

  @override
  Widget build(BuildContext context) {
    final appTextGenerator = boldText ? AppText.semiBold : AppText.regular;
    final titleView = appTextGenerator(title, size: 16, color: Colors.white);

    return Ink(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0XFFF68908), // todo color from AppColors
        gradient: const LinearGradient(colors: [Color(0XFFF68908), Color(0XFFFF9B3D)]),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Center(child: titleView),
      ),
    );
  }
}

class _AppLargeOutlinedButton extends StatelessWidget implements AppButton {
  const _AppLargeOutlinedButton({required this.title, this.onTap, this.prefixIcon});

  final String title;
  final String? prefixIcon;
  final VoidCallback? onTap;

  static Widget _iconView(String? iconSource) => iconSource != null //
      ? SvgGenImage(iconSource).svg()
      : const SizedBox();

  @override
  Widget build(BuildContext context) {
    final prefixIconView = _AppLargeOutlinedButton._iconView(prefixIcon);
    final titleView = Text(title, style: const TextStyle(color: Colors.black));
    const gap = SizedBox(width: 10);

    return Ink(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [prefixIconView, gap, titleView, gap],
        ),
      ),
    );
  }
}

class _AppTextButton extends StatelessWidget implements AppButton {
  const _AppTextButton({required this.title, this.onTap, this.underline = true});

  final String title;
  final VoidCallback? onTap;
  final bool underline;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onTap,
        child: AppText.medium(title, size: 12, color: AppColor.primary, isUnderline: underline),
      );
}

class _AppIconButton extends StatelessWidget implements AppButton {
  const _AppIconButton({required this.icon, this.onTap});

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(onPressed: onTap, icon: SvgPicture.asset(icon));
}

class _AppBlackRoundedButton extends StatelessWidget implements AppButton {
  const _AppBlackRoundedButton({required this.filled, this.title, this.icon, this.height = 50, this.onTap}) //
      : assert(title != null || icon != null);

  final String? icon;
  final String? title;
  final bool filled;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = filled ? AppColor.black : AppColor.white;
    final contentColor = filled ? AppColor.white : AppColor.black;
    final borderColor = filled ? backgroundColor : contentColor;

    final content = title != null //
        ? AppText.regular(title, color: contentColor)
        : SvgGenImage(icon!).svg(colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn));

    return Material(
      child: Ink(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
          color: backgroundColor,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Center(child: content),
        ),
      ),
    );
  }
}
