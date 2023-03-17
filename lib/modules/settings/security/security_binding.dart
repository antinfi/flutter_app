import 'package:get/get.dart';

import 'security_controller.dart';

class SecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SecurityController());
  }
}
