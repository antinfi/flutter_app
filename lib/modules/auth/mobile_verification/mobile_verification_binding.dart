import 'package:get/get.dart';

import 'mobile_verification_controller.dart';

class MobileVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MobileVerificationController());
  }
}
