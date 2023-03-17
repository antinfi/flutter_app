import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import 'app_text.dart';

abstract class PasswordUtil {
  static final _passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  static final _minimumLengthRegex = RegExp(r'^.{8,}$');
  static final _uppercaseRegex = RegExp('^(?=.*?[A-Z])');
  static final _lowercaseRegex = RegExp('^(?=.*?[a-z])');
  static final _digitRegex = RegExp('^(?=.*?[0-9])');
  static final _specialRegex = RegExp(r'^(?=.*?[!@#$&*~])');

  static bool isValid(String? input) => _passwordRegex.hasMatch(input ?? '');

  static bool hasMinimumLength(String input) => _minimumLengthRegex.hasMatch(input);

  static bool hasUppercase(String input) => _uppercaseRegex.hasMatch(input);

  static bool hasLowercase(String input) => _lowercaseRegex.hasMatch(input);

  static bool hasDigit(String input) => _digitRegex.hasMatch(input);

  static bool hasSpecialCharacter(String input) => _specialRegex.hasMatch(input);
}

class PasswordValidatorWidget extends StatelessWidget {
  final String password;

  const PasswordValidatorWidget(this.password, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ItemWidget(password, '• 8 characters', PasswordUtil.hasMinimumLength),
            _ItemWidget(password, '• capital letter', PasswordUtil.hasUppercase),
            _ItemWidget(password, '• small letter', PasswordUtil.hasLowercase),
            _ItemWidget(password, '• number', PasswordUtil.hasDigit),
            _ItemWidget(password, r'• special character (!@#$...)', PasswordUtil.hasSpecialCharacter),
          ],
        ),
      );
}

class _ItemWidget extends StatelessWidget {
  final String password;
  final String text;
  final _ValidatorCallback validation;

  const _ItemWidget(this.password, this.text, this.validation);

  @override
  Widget build(BuildContext context) => AppText.regular(
        text,
        size: 12,
        color: password.isEmpty ? AppColor.disableTextColor : (validation(password) ? AppColor.success : AppColor.error),
      );
}

typedef _ValidatorCallback = bool Function(String text);
