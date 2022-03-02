import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_payment/app/services/log.dart';
import '../../../services/db_services/database_operations.dart';
import '../../../models/products_model.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/dialog_box/custom_confirm_dialog_box.dart';

enum Operation {edit, add, view}

class AddProductController extends GetxController {

  final products = Products().obs;
  final dbo = DBO();

  final nameText = "".obs;
  final descText = "".obs;
  final priceText = "".obs;

  final operation = Operation.add.obs;
  final nameTextEditingController = TextEditingController().obs;
  final descriptionTextEditingController = TextEditingController().obs;
  final priceTextEditingController = TextEditingController().obs;

  final nameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final priceFocusNode = FocusNode();
  final title = "Add Product".obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    nameTextEditingController.value.addListener(() {
      products.value.productName = nameTextEditingController.value.text;
      nameText.value = nameTextEditingController.value.text;
    });
    descriptionTextEditingController.value.addListener(() {
      products.value.productDescription = descriptionTextEditingController.value.text;
      descText.value = descriptionTextEditingController.value.text;
    });
    priceTextEditingController.value.addListener(() {
      if(priceTextEditingController.value.text.isNotEmpty) {
        products.value.price = double.parse(priceTextEditingController.value.text);
        priceText.value = priceTextEditingController.value.text;
      }
    });

    var data = Get.arguments;
    if(data != null) {
      Products x = Products.fromJson(Get.arguments["product"]);
      title.value = "${x.productName}";
      products.value = x;
      nameTextEditingController.value.text = "${x.productName}";
      descriptionTextEditingController.value.text = "${x.productDescription}";
      priceTextEditingController.value.text = "${x.price}";
      operation.value = Operation.view;
    }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  saveProduct(BuildContext context) async {

    switch(operation.value) {
      case Operation.add:
        if(validate()) {
          products.value.id ??= Uuid().v1();
          Get.back(result: {
            "product":products.value,
            "operation":"add"
          });
        }
        break;
      case Operation.edit:
        if(validate()) {
          Get.back(result: {
            "product":products.value,
            "operation":"edit"
          });
        }

        break;
      default:

        showCustomConfirmDialogBox(
          context,
          title: "Delete Product",
          content: "Are you sure you want to delete ${products.value.productName}?",
          onCancel: (){

          },
          onConfirm: (){
            Get.back(result: {
              "product":products.value,
              "operation":"delete"
            });
          }
        );
        break;
    }
  }

  bool validate(){
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  edit(BuildContext context){
    operation.value = Operation.edit;
    FocusScope.of(context).requestFocus(nameFocusNode);
  }



}
