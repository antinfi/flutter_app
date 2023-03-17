import 'package:get/get.dart';

import 'identification_document_controller.dart';

class IdentificationDocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IdentificationDocumentController());
  }
}
