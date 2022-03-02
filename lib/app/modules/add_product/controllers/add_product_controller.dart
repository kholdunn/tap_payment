import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tap_payment/app/services/log.dart';
import '../../../services/db_services/database_operations.dart';
import '../../../models/products_model.dart';
import 'package:uuid/uuid.dart';

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
      Log.n("ASdfsadjkgh", x.id);
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

  saveProduct(){

    switch(operation.value) {
      case Operation.add:
        products.value.id ??= Uuid().v1();
        Get.back(result: {
          "product":products.value,
          "operation":"add"
        });
        break;
      case Operation.edit:
        Get.back(result: {
          "product":products.value,
          "operation":"edit"
        });
        break;
      default:
        Get.back(result: {
          "product":products.value,
          "operation":"delete"
        });
        break;
    }
  }

  edit(BuildContext context){
    operation.value = Operation.edit;
    FocusScope.of(context).requestFocus(nameFocusNode);
  }



}
