import 'package:get/get.dart';

extension $ExtraGetxExtension on GetInterface {
  /// reset instance by delete and put the Instance<[T]> back
  /// - [dependency] The Instance to be reset
  /// - [tag] optionally
  T resetInstance<T>(T dependency, {String? tag}) {
    GetInstance().delete<T>(tag: tag, force: true);
    return Get.put<T>(dependency, tag: tag);
  }

  /// Finds a Instance of the required Class <[T]>(or [tag]) or null without throwing error
  T? findOrNull<T>({String? tag}) {
    try {
      return Get.find<T>(tag: tag);
    } catch (e) {
      return null;
    }
  }
}

extension ExtraRxIntExt on Rx<int> {
  /// increase `this` by [step].
  void increase({int step = 1}) => value = value + step;

  /// decrease `this` by [step].
  void decrease({int step = 1}) => value = value - step;
}
