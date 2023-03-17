import '../config/config.dart';

class BottomSheetCommonUI extends StatelessWidget {
  final List<Widget> children;

  const BottomSheetCommonUI({required this.children, super.key});

  @override
  Widget build(BuildContext context) => Material(
        color: AppColor.transparent,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(16),
              Container(
                width: context.width * 0.15,
                height: 3,
                decoration: BoxDecoration(color: AppColor.bottomSheetTab, borderRadius: BorderRadius.circular(8)),
              ),
              const Gap(24),
              ...children,
              Gap(context.navigationBarHeight + 16),
            ],
          ),
        ),
      );
}
