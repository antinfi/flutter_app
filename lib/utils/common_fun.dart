import 'package:flutter/material.dart';
import 'package:get/get.dart';

void hideKeyboard() {
  if (Get.context == null) return;
  final currentFocus = FocusScope.of(Get.context!);
  if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
