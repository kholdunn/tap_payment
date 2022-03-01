import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tap_payment/app/constants/variable_constants.dart';
import 'package:tap_payment/app/widgets/custom_button/custom_button.dart';
import 'package:tap_payment/app/widgets/custom_text_input/custom_text_input_text_suffix.dart';
import '../../../widgets/custom_app_bar/custom_app_bar.dart';

import '../../../widgets/custom_text_input/custom_text_input.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Product",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextInput(
              label: "Product Name",
              textEditingController: controller.nameTextEditingController.value,
            ),
            CustomTextInput(
              label: "Product Description",
              textEditingController: controller.descriptionTextEditingController.value,

            ),
            CustomTextInput(
              label: "Product Price",
              textEditingController: controller.priceTextEditingController.value,
              suffix: CustomTextInputTextSuffix(VariableConstants.currency),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                LengthLimitingTextInputFormatter(10)
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true)
            ),
            Obx(() => CustomButton(
              child: Text("Submit"),
              onPressed: controller.nameText.value != "" &&
                controller.descText.value != "" &&
                  controller.priceText.value != "" ? () {
                  controller.saveProduct();
              } : null,
            ))
          ],
        ),
      ),
    );
  }
}
