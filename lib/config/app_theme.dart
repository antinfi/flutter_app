import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColor.appBackground,
    fontFamily: FontFamily.sFCompactDisplay,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      background: AppColor.background,
      onBackground: AppColor.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.white,
      titleTextStyle: AppTextStyle.appBarText,
      iconTheme: IconThemeData(color: AppColor.black),
      centerTitle: true,
      elevation: 1,
    ),
    cardTheme: const CardTheme(surfaceTintColor: AppColor.white),
  );
}
