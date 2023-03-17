import 'dart:async';

import 'package:sms_autofill/sms_autofill.dart';

import '../../../config/config.dart';

class MobileVerificationController extends BaseController with CodeAutoFill {
  var phoneNumber = '';

  ///otp-fields controller
  final otpController = TextEditingController();
  final isOtpValid = false.obs;

  final remainTime = ''.obs;

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();

    phoneNumber = (Get.arguments as String?) ?? '';

    final endTime = DateTime.now().add(const Duration(seconds: 120));
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final diff = endTime.difference(DateTime.now());
        remainTime.value = '${diff.inSeconds}s';
        if (endTime.difference(DateTime.now()).inSeconds <= 0) {
          remainTime.value = '';
          timer.cancel();
        }
      },
    );

    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      debugPrint('MobileVerificationController.onInit: $signature');
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    cancel();
    super.onClose();
  }

  @override
  void codeUpdated() {
    otpController.text = code ?? '';
  }

  void resendCode() {
    final map = {
      'phone': phoneNumber,
    };
    callApi(authClient.resendCode(map)).then((value) {
      if (value != null) {
        showSuccess('Resend successfully');
      }
    });
  }

  void verifyOtp() {
    final code = otpController.text.trim();
    callApi(authClient.verify(code, {'verifyCode': code})).then((value) {
      if (value != null) {
        Get.toNamed(AppRoute.personalInformation);
      }
    });
  }
}
