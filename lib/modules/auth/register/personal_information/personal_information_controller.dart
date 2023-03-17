import 'package:image_picker/image_picker.dart';

import '../../../../config/config.dart';
import '../../../../widgets/custom_date_picker.dart';

class PersonalInformationController extends BaseController {
  final formKey = GlobalKey<FormState>();

  final _picker = ImagePicker();
  final selfieImage = Rxn<XFile>();

  final firstNameTextController = TextEditingController();
  final middleNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final dateTimeTextController = TextEditingController();
  final countryTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final streetNumberTextController = TextEditingController();

  final isMale = true.obs;

  DateTime? selectedDate;

  Future<void> selectImage() async {
    final result = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
      preferredCameraDevice: CameraDevice.front,
      requestFullMetadata: false,
    );

    if (result != null) {
      selfieImage.value = result;
    }
  }

  Future<void> onNext() async {
    if (selfieImage.value == null) {
      openWarningDialog('Please upload selfie');
      return;
    }

    if (!(formKey.currentState?.validate() ?? false)) return;

    hideKeyboard();

    showAppLoader();

    final map = {
      'firstName': firstNameTextController.text.trim(),
      'middleName': middleNameTextController.text.trim(),
      'lastName': lastNameTextController.text.trim(),
      'birthDate': selectedDate?.toFormat('yyyy-MM-dd'),
      'gender': isMale.value ? 'male' : 'female',
      'city': cityTextController.text.trim(),
      'address': streetNumberTextController.text.trim(),
      'profileImage': await selfieImage.value?.toBase64(),
    };

    await callApi(authClient.updateDetail(map), showLoader: false).then((value) {
      dismissAppLoader();
      if (value != null) {
        Get.offAllNamed(AppRoute.home);
        appPref
          ..isLogin = true
          ..userData = value;
      }
    }, onError: (error) {
      dismissAppLoader();
    });
  }

  void openDatePicker() {
    openCustomDatePicker(selectedDate: selectedDate, maximumDate: DateTime.now()).then((value) {
      if (value != null) {
        if ((365 * 18) < DateTime.now().difference(value).inDays) {
          selectedDate = value;
          dateTimeTextController.text = value.toFormat('dd / MM / yyyy');
        } else {
          openWarningDialog('israeliRegulation18Year'.tr);
        }
      }
    });
  }
}
