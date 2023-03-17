import 'package:image_picker/image_picker.dart';

import '../../../../config/config.dart';
import '../../../../widgets/custom_date_picker.dart';
import '../../../../widgets/select_image_bottom_sheet.dart';
import '../../../common/choose_country_dialog/choose_country_dialog.dart';

class IdentificationDocumentController extends BaseController {
  final formKey = GlobalKey<FormState>();

  final documentImage = Rxn<XFile>();
  final anotherDocumentImage = Rxn<XFile>();

  final identityNumberTextController = TextEditingController();
  final identificationCountryTextController = TextEditingController();
  final dateOfExpiryTextController = TextEditingController();
  final documentPlaceOfIssueTextController = TextEditingController();

  final isPassport = false.obs;
  DateTime? expiryDate;
  AppCountry? identificationCountry;
  AppCountry? documentIssueCountry;

  void uploadDocument() {
    openImageSelector(
      title: 'uploadOfficialDocument'.tr,
      onFileSelect: (file) {
        if (documentImage.value == null) {
          documentImage.value = file;
        } else {
          anotherDocumentImage.value = file;
        }
      },
    );
  }

  void openDatePicker() {
    final now = DateTime.now();
    openCustomDatePicker(
      selectedDate: expiryDate,
      minimumDate: now,
      maximumDate: now.add(const Duration(days: 365 * 100)),
    ).then((value) {
      if (value != null) {
        expiryDate = value;
        dateOfExpiryTextController.text = value.toFormat('dd / MM / yyyy');
      }
    });
  }

  void openIdentificationCountryPicker() {
    Get.bottomSheet<AppCountry>(const ChooseCountryDialog()).then((value) {
      if (value != null) {
        identificationCountry = value;
        identificationCountryTextController.text = value.name;
      }
    });
  }

  void openDocumentIssueCountryPicker() {
    Get.bottomSheet<AppCountry>(const ChooseCountryDialog()).then((value) {
      if (value != null) {
        documentIssueCountry = value;
        documentPlaceOfIssueTextController.text = value.name;
      }
    });
  }

  Future<void> onSendTap() async {
    if (documentImage.value == null) {
      openWarningDialog('Please select document');
      return;
    }

    if (!(formKey.currentState?.validate() ?? false)) return;

    hideKeyboard();

    showAppLoader();

    final map = {
      'typeId': isPassport.value ? 2 : 1,
      'number': identityNumberTextController.text.trim(),
      'countryId': identificationCountry?.id,
      // 'dateOfIssue': '',
      'expire': expiryDate?.toFormat('yyyy-MM-dd'),
      'image': await documentImage.value?.toBase64(),
    };

    await callApi(authClient.createIdentity(map), showLoader: false).then((value) {
      dismissAppLoader();
      if (value != null) {
        Get.toNamed(AppRoute.accountInformation, arguments: value);
      }
    }, onError: (error) {
      dismissAppLoader();
    });
  }

  void removeAnotherDocument() {
    anotherDocumentImage.value = null;
  }
}
