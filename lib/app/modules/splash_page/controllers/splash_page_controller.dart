import 'package:get/get.dart';
import 'package:tap_payment/app/routes/app_pages.dart';
import 'package:tap_payment/app/services/db_services/shared_preferences.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    SP.init();

  }

  @override
  void onReady() {
    super.onReady();

    Future.delayed(Duration(seconds: 1)).then((_){
      Get.offAllNamed(Routes.MANAGE_PRODUCTS);
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
