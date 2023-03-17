import '../../../config/config.dart';
import '../../../widgets/bottom_sheet_common_ui.dart';
import 'choose_country_controller.dart';

class ChooseCountryDialog extends StatefulWidget {
  const ChooseCountryDialog({Key? key}) : super(key: key);

  @override
  State<ChooseCountryDialog> createState() => _ChooseCountryDialogState();
}

class _ChooseCountryDialogState extends State<ChooseCountryDialog> {
  final controller = Get.put(ChooseCountryController());

  @override
  void dispose() {
    Get.delete<ChooseCountryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BottomSheetCommonUI(
        children: [
          AppText.semiBold('chooseCountry'.tr, size: 17, color: AppColor.dialogText),
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: const [
                BoxShadow(
                  color: AppColor.dropShadow,
                  blurRadius: 22,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsetsDirectional.all(24),
            child: TextField(
              controller: controller.searchTextController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
                hintText: 'search'.tr,
                hintStyle: AppTextStyle.searchBoxText,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                suffixIcon: IconButton(icon: Assets.icons.searchWithBorder.svg(width: 32, height: 32), onPressed: () {}),
              ),
              // add your text input field properties here
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: context.height) * 0.3,
            child: Obx(() => ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Get.back(result: controller.filteredList[index]),
                    child: Obx(() => _CountryItem(
                          item: controller.filteredList[index],
                          isSelected: controller.selectedCountryId.value == controller.filteredList[index].id,
                        )),
                  ),
                )),
          ),
        ],
      );
}

class _CountryItem extends StatelessWidget {
  final AppCountry item;
  final bool isSelected;

  const _CountryItem({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) => Container(
        height: kToolbarHeight,
        color: isSelected ? AppColor.selectedCountry : AppColor.transparent,
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            // Image.asset(item.flag),
            const Gap(8),
            AppText.medium(item.name, size: 15, color: AppColor.dialogText),
            const Spacer(),
            if (isSelected) Assets.icons.check.svg(),
          ],
        ),
      );
}
