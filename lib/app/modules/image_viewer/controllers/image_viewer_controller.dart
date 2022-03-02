
import 'package:get/get.dart';


import 'package:flutter/material.dart' hide Image;

typedef DoubleClickAnimationListener = void Function();

class ImageViewerController extends GetxController {


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // doubleClickAnimationController = AnimationController(
    //     duration: const Duration(milliseconds: 150), vsync: this);


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
