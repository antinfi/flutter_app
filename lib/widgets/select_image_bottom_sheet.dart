import 'package:image_picker/image_picker.dart';

import '../config/config.dart';
import 'bottom_sheet_common_ui.dart';

typedef OnFileSelect = Function(XFile file);

void openImageSelector({required String title, required OnFileSelect onFileSelect}) {
  Get.bottomSheet(SelectImageBottomSheet(title: title, onFileSelect: onFileSelect));
}

class SelectImageBottomSheet extends StatelessWidget {
  final String? title;
  final OnFileSelect onFileSelect;

  SelectImageBottomSheet({required this.title, required this.onFileSelect, super.key});

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) => BottomSheetCommonUI(
        children: [
          AppText.medium(title, size: 16, color: AppColor.dialogText),
          const Gap(24),
          ListTile(
            leading: Assets.icons.galleryWithBorder.svg(),
            title: AppText.medium('chooseFromGallery'.tr, color: AppColor.dialogText),
            onTap: () {
              Get.back();
              _picker.pickImage(source: ImageSource.gallery, requestFullMetadata: false, maxWidth: 1080, maxHeight: 1080).then((value) {
                if (value != null) {
                  onFileSelect(value);
                }
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: Assets.icons.cameraWithBorder.svg(),
            title: AppText.medium('takePhoto'.tr, color: AppColor.dialogText),
            onTap: () {
              Get.back();
              _picker.pickImage(source: ImageSource.camera, requestFullMetadata: false, maxWidth: 1080, maxHeight: 1080).then((value) {
                if (value != null) {
                  onFileSelect(value);
                }
              });
            },
          ),
          const Divider(),
        ],
      );
}
