import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/splash_page_controller.dart';

class SplashPageView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (pressController) {
          return Scaffold(
            body: Center(
              child: FlutterLogo(
                size: 20.w,
              ),
            ),
          );
        }
    );
  }
}
