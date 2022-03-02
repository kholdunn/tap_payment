import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:tap_payment/app/models/products_model.dart';
import 'package:tap_payment/app/routes/app_pages.dart';
import 'package:tap_payment/app/services/log.dart';

import '../../../services/db_services/database_operations.dart';
import '../../../services/db_services/shared_preferences.dart';
import '../../../widgets/custom_snackbar/custom_snackbar.dart';
import '../../../widgets/dialog_box/custom_confirm_dialog_box.dart';

class ManageProductsController extends GetxController {

  final dbo = DBO();

  final themeMode = ThemeMode.system.obs;
  final nextTheme = ThemeMode.system.obs;
  List<Products> productList = [];
  final filteredProductList = List<Products>.empty(growable : true).obs;
  final searchTextEditingController = TextEditingController().obs;
  final _debouncer = Debouncer(delay: Duration(milliseconds: 500));

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
    productList = p.map((e) => Products.fromJson(jsonDecode(e))).toList();
    filter();
    c.complete(true);
    return c.future;
  }

  openItem(BuildContext context, {required Products product}) {
    Get.toNamed(Routes.ADD_PRODUCT, arguments: {
      "product":product.toJson()
    })?.then((value){
      if(value != null) {
        Products x = value["product"] as Products;

        if(x.id != null) {
          String operation = "";
          int index = productList.indexWhere((element) => element.id == x.id);
          if(value["operation"] == "delete") {
            operation = "deleted";
            productList[index].reactive();
            dbo.deleteProduct(jsonEncode(x.toJson()));
          } else {
            operation = "updated";
            productList[index].reactive(x);
            dbo.updateProduct(jsonEncode(x.toJson()));
          }
          filter();
          CustomSnackBar(context, message: "Product was $operation successfully",).show(context);
        }
      }
    });
  }

  updateList(BuildContext context){
    Get.toNamed(Routes.ADD_PRODUCT)?.then((value){

      if(value != null) {

        Products x = value["product"] as Products;
        if(x.id != null) {
          productList.add(x);
          dbo.addProduct(jsonEncode(x));
          filter();
          CustomSnackBar(context, message: "Product was added successfully",).show(context);
        }
      }
    });
  }

  deleteProduct(String id){
    int index = productList.indexWhere((element) => element.id == id);
    productList.removeWhere((element) => element.id == id);
    filter();
  }

  deleteAllProduct(BuildContext context){
    showCustomConfirmDialogBox(
        context,
        title: "Delete All Products",
        content: "Are you sure you want to delete all products?",
        onCancel: (){

        },
        onConfirm: (){
          productList.clear();
          dbo.deleteAllProducts();
          filter();
        }
    );

  }

  filter({String query = ""}) {
    filteredProductList.assignAll(productList.where((element) => (element.productName?.toLowerCase().contains(query.toLowerCase()) ?? false)));
  }

}
