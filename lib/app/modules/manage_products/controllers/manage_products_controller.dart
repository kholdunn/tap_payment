import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_payment/app/models/products_model.dart';
import 'package:tap_payment/app/routes/app_pages.dart';
import 'package:tap_payment/app/services/log.dart';

import '../../../services/db_services/database_operations.dart';
import '../../../services/db_services/shared_preferences.dart';
import '../../../widgets/custom_snackbar/custom_snackbar.dart';

class ManageProductsController extends GetxController {

  final dbo = DBO();

  final themeMode = ThemeMode.system.obs;
  final nextTheme = ThemeMode.system.obs;
  final productList = List<Products>.empty(growable : true).obs;
  final searchTextEditingController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    String mode = SP.getData(dataType: DataType.string, key: 'theme') ?? "ThemeMode.system";

    nextTheme.value = ThemeMode.values.firstWhere((element) => element.toString() == mode);
    changeTheme();

  }

  @override
  void onClose() {}


  changeTheme() {
    switch(nextTheme.value) {
      case ThemeMode.light:
        themeMode.value = ThemeMode.light;
        nextTheme.value = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        themeMode.value = ThemeMode.dark;
        nextTheme.value = ThemeMode.system;
        break;
      default:
        themeMode.value = ThemeMode.system;
        nextTheme.value = ThemeMode.light;
        break;
    }
    Get.changeThemeMode(themeMode.value);
    SP.storeData(dataType: DataType.string, key: "theme", value: themeMode.value.toString());
  }

  Future<bool> getData()async{
    Completer<bool> c = Completer();
    List<String> p = await dbo.getProductList();
    productList.assignAll(p.map((e) => Products.fromJson(jsonDecode(e))));
    // productList.value = p.map((e) => Products.fromJson(jsonDecode(e))).toList();
    c.complete(true);
    return c.future;
  }

  updateList(BuildContext context){
    Get.toNamed(Routes.ADD_PRODUCT)?.then((value){
      if(value != null) {
        Products x = value as Products;
        if(x.id != null) {
          String operation = "";
          int index = productList.value.indexWhere((element) => element.id == x.id);
          if(index > -1) {
            operation = "updated";
            productList.value[index].reactive(x);
            dbo.updateProduct(jsonEncode(x));
          } else {
            productList.reactive.value?.add(x);
            operation = "added";
            dbo.addProduct(jsonEncode(x));
          }
          CustomSnackBar(context, message: "Product was $operation successfully",)..show(context);
        }
      }
    });
  }

  deleteProduct(String id){
    int index = productList.value.indexWhere((element) => element.id == id);
    productList.removeWhere((element) => element.id == id);
  }

  deleteAllProduct(){
    productList.assignAll([]);
    dbo.deleteAllProducts();
  }


}
