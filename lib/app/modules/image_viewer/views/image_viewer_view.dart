import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tap_payment/app/routes/app_pages.dart';
import 'package:tap_payment/app/widgets/custom_app_bar/custom_app_bar.dart';

import '../../../widgets/custom_icon_button/custom_icon_button.dart';
import '../controllers/image_viewer_controller.dart';

class ImageViewerView extends GetView<ImageViewerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Image Viewer",
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ExtendedImage.network(
        "https://picsum.photos/800",
        width: double.maxFinite,
        height: double.maxFinite,
        fit: BoxFit.contain,
        initGestureConfigHandler: (state) {
          return GestureConfig(
            minScale: 0.9,
            animationMinScale: 0.7,
            maxScale: 3.0,
            animationMaxScale: 3.5,
            speed: 1.0,
            inertialSpeed: 100.0,
            initialScale: 1.0,
            inPageView: false,
            initialAlignment: InitialAlignment.center,
          );
        },

        mode: ExtendedImageMode.gesture,
        cache: false,

      ),
    );
  }
}
