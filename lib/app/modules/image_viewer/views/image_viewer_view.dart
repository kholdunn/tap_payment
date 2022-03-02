import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
        actions: [
          CustomIconButton(
            onPressed: (){

            },
            icon: Icons.camera_alt_outlined,
          )
        ],
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
        // onDoubleTap: (ExtendedImageGestureState state) {
        //   final Offset? pointerDownPosition =
        //       state.pointerDownPosition;
        //   final double? begin = state.gestureDetails!.totalScale;
        //   double end;
        //
        //   //remove old
        //   controller.doubleClickAnimation
        //       ?.removeListener(controller.doubleClickAnimationListener);
        //
        //   //stop pre
        //   controller.doubleClickAnimationController.stop();
        //
        //   //reset to use
        //   controller.doubleClickAnimationController.reset();
        //
        //   if (begin == controller.doubleTapScales[0]) {
        //     end = controller.doubleTapScales[1];
        //   } else {
        //     end = controller.doubleTapScales[0];
        //   }
        //
        //   controller.doubleClickAnimationListener = () {
        //     //print(_animation.value);
        //     state.handleDoubleTap(
        //         scale: controller.doubleClickAnimation!.value,
        //         doubleTapPosition: pointerDownPosition);
        //   };
        //   controller.doubleClickAnimation = controller.doubleClickAnimationController
        //       .drive(Tween<double>(begin: begin, end: end));
        //
        //   controller.doubleClickAnimation!
        //       .addListener(controller.doubleClickAnimationListener);
        //
        //   controller.doubleClickAnimationController.forward();
        // },
        cache: true,

      ),
    );
  }
}
