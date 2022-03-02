import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/models/products_model.dart';
import 'package:tap_payment/app/routes/app_pages.dart';
import 'package:tap_payment/app/services/log.dart';
import 'package:tap_payment/app/widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:tap_payment/app/widgets/custom_item_list/sort_item_list.dart';
import 'package:tap_payment/app/widgets/proceed_button/proceed_button.dart';

import '../../../services/db_services/database_operations.dart';
import '../../../services/db_services/shared_preferences.dart';
import '../../../widgets/custom_snackbar/custom_snackbar.dart';
import '../../../widgets/dialog_box/custom_confirm_dialog_box.dart';



class ManageProductsController extends GetxController {

  final dbo = DBO();

  final themeMode = ThemeMode.system.obs;
  final nextTheme = ThemeMode.system.obs;
  final productList = <Products>[].obs;
  final filteredProductList = List<Products>.empty(growable : true).obs;
  final searchTextEditingController = TextEditingController().obs;
  final activeSorting = "date".obs;

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
    filteredProductList.assignAll(
      productList.where(
        (element) => ((element.productName?.toLowerCase().startsWith(query.toLowerCase()) ?? false) ||
            (element.productDescription?.toLowerCase().startsWith(query.toLowerCase()) ?? false) ||
            (element.price?.toString().startsWith(query.toLowerCase()) ?? false)
        )
      )
    );
    sort();
  }

  sort(){
    if(filteredProductList.value.isNotEmpty) {
      switch(activeSorting.value) {
        case "name":
          filteredProductList.sort((a, b) => a.productName!.compareTo(b.productName!));
          break;
        case "price":
          filteredProductList.sort((a, b) => a.price!.compareTo(b.price!));
          break;
        default:
          filteredProductList.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
          break;
      }

    }
  }

  sortModal(BuildContext context){
    showCustomBottomSheet(context,
        title: "Sort",
        closeButtonName: "Done",
        sortItemList: [
          Obx(()=>SortItemList(
              title: "Product Name",
              active: activeSorting.value == "name",
              onPressed: (){
                activeSorting.value = "name";
                sort();
              }
          )),
          Obx(()=>SortItemList(
              title: "Price",
              active: activeSorting.value == "price",
              onPressed: (){
                activeSorting.value = "price";
                sort();
              }
          )),
          Obx(()=>SortItemList(
              title: "Date Added",
              active: activeSorting.value == "date",
              onPressed: (){
                activeSorting.value = "date";
                sort();
              }
          )),
        ]
    );
  }

}
