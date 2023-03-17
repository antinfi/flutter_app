import 'package:get/get.dart';

import 'set_new_password_controller.dart';

class SetNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SetNewPasswordController());
  }
}
