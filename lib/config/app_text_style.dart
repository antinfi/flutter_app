import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';
import 'app_colors.dart';

abstract class AppTextStyle {
  static const appBarText = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.sFCompactDisplay,
  );

  static const defaultText = TextStyle(
    color: AppColor.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const defaultHint = TextStyle(
    color: AppColor.textSecondary,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const textFieldText = TextStyle(
    color: AppColor.textFieldText,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const textFieldError = TextStyle(
    color: AppColor.error,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const textFieldHint = TextStyle(
    color: AppColor.textSecondaryLight,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const textFieldFillHint = TextStyle(
    color: AppColor.textFieldHint,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const dateTextStyle = TextStyle(
    color: AppColor.datePickerText,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const selectedDateTextStyle = TextStyle(
    color: AppColor.datePickerText,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const searchBoxText = TextStyle(
    color: AppColor.dialogText,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const pinCodeText = TextStyle(
    color: AppColor.pinText,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const pinCodeHint = TextStyle(
    color: AppColor.textSecondaryLight,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}
