import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/image_viewer/bindings/image_viewer_binding.dart';
import '../modules/image_viewer/views/image_viewer_view.dart';
import '../modules/manage_products/bindings/manage_products_binding.dart';
import '../modules/manage_products/views/manage_products_view.dart';
import '../modules/splash_page/bindings/splash_page_binding.dart';
import '../modules/splash_page/views/splash_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_PRODUCTS,
      page: () => ManageProductsView(),
      binding: ManageProductsBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashPageView(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_VIEWER,
      page: () => ImageViewerView(),
      binding: ImageViewerBinding(),
    ),
  ];
}
