import 'package:get/get.dart';

import 'account_information_controller.dart';

class AccountInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountInformationController());
  }
}
