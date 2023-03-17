import 'package:flutter/material.dart';

import '../config/app_colors.dart';

enum MessageType { info, warn, success, error, others }

class MessageHelper {
  GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  void hide() => messengerKey.currentState?.removeCurrentSnackBar();

  void showError(String message, {Duration? duration}) => _showMessage(message, MessageType.error, duration: duration);

  void showInfo(String message, {Duration? duration}) => _showMessage(message, MessageType.info, duration: duration);

  void showWarn(String message, {Duration? duration}) => _showMessage(message, MessageType.warn, duration: duration);

  void showSuccess(String message, {Duration? duration}) => _showMessage(message, MessageType.success, duration: duration);

  void showRetryError(String message, {Duration? duration, String btnText = 'Retry', VoidCallback? onBtnPress}) =>
      _showMessage(message, MessageType.others, duration: duration, btnText: btnText, onBtnPress: onBtnPress);

  void _showMessage(String message, MessageType type, {Duration? duration, String btnText = 'Close', VoidCallback? onBtnPress}) {
    if (message.isEmpty) return;
    messengerKey.currentState?.removeCurrentSnackBar();

    duration ??= const Duration(milliseconds: 3000);
    Color? backgroundColor;
    Color? textColor;
    switch (type) {
      case MessageType.info:
        backgroundColor = AppColor.info;
        break;
      case MessageType.warn:
        backgroundColor = AppColor.warning;
        break;
      case MessageType.success:
        backgroundColor = AppColor.success;
        break;
      case MessageType.error:
        backgroundColor = AppColor.error;
        break;
      case MessageType.others:
        textColor = AppColor.white;
        break;
    }
    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: backgroundColor,
      content: Text(message, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: btnText,
        textColor: backgroundColor == null ? null : textColor,
        onPressed: () {
          messengerKey.currentState?.hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
          onBtnPress?.call();
        },
      ),
    );
    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
