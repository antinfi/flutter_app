import 'dart:ui';

import 'package:flutter/material.dart';

const smallScreenWidth = 700.0;
const largeScreenWidth = 1200.0;

extension BuildContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  double get statusBarHeight => mediaQuery.padding.top;

  double get navigationBarHeight => mediaQuery.padding.bottom;

  bool get isKeyboardOpen => 0 < mediaQuery.viewInsets.bottom;

  /// Returns same as Keyboard size in px
  double get keyboardHeightPx => mediaQuery.viewInsets.bottom;

  /// Returns same as Keyboard size in point
  double get keyboardHeight {
    final actualKeyboardHeight = mediaQuery.viewInsets.bottom;
    if (actualKeyboardHeight == 0) return 0;
    return mediaQuery.size.height * (actualKeyboardHeight / window.physicalSize.height);
  }

  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  double get bottomPadding => mediaQuery.padding.bottom;

  double get bottomInset => mediaQuery.viewInsets.bottom;

  double bottomPaddingIfNeeded([double minPadding = 8]) => (0 < mediaQuery.padding.bottom) ? mediaQuery.padding.bottom : minPadding;

  double bottomSpace([double minPadding = 8]) {
    final bottomPadding = mediaQuery.padding.bottom;
    return (minPadding < bottomPadding) ? bottomPadding : minPadding;
  }

  bool get isMobile => MediaQuery.of(this).size.width < smallScreenWidth;

  bool get isTablet => MediaQuery.of(this).size.width >= smallScreenWidth && MediaQuery.of(this).size.width <= largeScreenWidth;

  bool get isDesktop => MediaQuery.of(this).size.width > largeScreenWidth;
}
