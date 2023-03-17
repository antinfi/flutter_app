import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/route_finder.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  Future<void> onInit() async {
    super.onInit();
    _animationInitilization();
    await _animationController.forward(); // animate logo
    await Get.offAndToNamed(RouteFinder.findNextRoute());
  }

  void _animationInitilization() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut).obs.value;
    _animation.addListener(update);
  }

  double get animationValue => _animation.value;
}
