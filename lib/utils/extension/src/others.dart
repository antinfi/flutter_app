import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'data_type.dart';

extension ScopeFunctionsForObject<T extends Object> on T {
  /// kotlin style scope function let
  ReturnType let<ReturnType>(ReturnType Function(T self) operationFor) => operationFor(this);
}

extension TextEditingControllerExt on TextEditingController {
  int get toInt => int.tryParse(text.trim()) ?? 0;

  double get toDouble => double.tryParse(text.trim()) ?? 0.0;
}

extension XFileExt on XFile {
  Future<String> toBase64() async {
    final base64Bytes = base64Encode(await readAsBytes());
    final fileExtension = path.fileExtension;
    return 'data:image/${fileExtension == 'jpg' ? 'jpeg' : fileExtension};base64,$base64Bytes';
  }
}
