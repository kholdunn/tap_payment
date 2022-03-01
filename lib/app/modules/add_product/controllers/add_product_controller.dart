import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tap_payment/app/services/log.dart';
import '../../../services/db_services/database_operations.dart';
import '../../../models/products_model.dart';
import 'package:uuid/uuid.dart';


class AddProductController extends GetxController {

  final products = Products().obs;
  final dbo = DBO();

  final nameText = "".obs;
  final descText = "".obs;
  final priceText = "".obs;


  final nameTextEditingController = TextEditingController().obs;
  final descriptionTextEditingController = TextEditingController().obs;
  final priceTextEditingController = TextEditingController().obs;

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

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  saveProduct(){

    Log.n("nameText.value", nameText.value);
    Log.n("descText.value", descText.value);
    Log.n("priceText.value", priceText.value);

    products.value.id ??= Uuid().v1();
    Get.back(result: products.value);

  }

}
