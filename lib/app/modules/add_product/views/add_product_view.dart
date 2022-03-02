import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/constants/variable_constants.dart';
import 'package:tap_payment/app/services/debug_ui.dart';
import 'package:tap_payment/app/widgets/custom_text_input/custom_text_input_text_suffix.dart';
import '../../../services/ui_reference.dart';
import '../../../widgets/custom_app_bar/custom_app_bar.dart';

import '../../../widgets/custom_icon_button/custom_icon_button.dart';
import '../../../widgets/custom_text_input/custom_text_input.dart';
import '../../../widgets/proceed_button/proceed_button.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Product",
        centerTitle: true,
        actions: [
          if(controller.operation.value != Operation.add)Obx(()=>CustomIconButton(
            onPressed: controller.operation.value != Operation.edit ? (){
              controller.edit(context);
            } : null,
            icon: Icons.edit,
          ))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onPanDown: (x){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: setupView(),
      ),
    );
  }

  setupView(){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w
      ),
      child: Column(
        children: [
          SizedBox(height: 4.h,),
          Obx(() =>CustomTextInput(
            label: "Product Name",
            textEditingController: controller.nameTextEditingController.value,
            readOnly: controller.operation.value == Operation.view,
            focusNode: controller.nameFocusNode,
          )),
          SizedBox(height: 1.3.h),
          Obx(()=>CustomTextInput(
            label: "Product Description",
            textEditingController: controller.descriptionTextEditingController.value,
            readOnly: controller.operation.value == Operation.view,
            focusNode: controller.descriptionFocusNode,
          )),
          SizedBox(height: 1.3.h),
          Obx(()=>CustomTextInput(
            label: "Product Price",
            textEditingController: controller.priceTextEditingController.value,
            suffix: CustomTextInputTextSuffix(VariableConstants.currency),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              LengthLimitingTextInputFormatter(10)
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            readOnly: controller.operation.value == Operation.view,
            focusNode: controller.priceFocusNode,
          )),
          SizedBox(height: 1.3.h),
          Obx(() => ProceedButton(
            title: controller.operation.value == Operation.view ? "Delete" :
              controller.operation.value == Operation.edit ? "Update" : "Submit",
            onPressed: controller.nameText.value != "" &&
                controller.descText.value != "" &&
                controller.priceText.value != "" ? () {
              controller.saveProduct();
            } : null,
          ))
        ],
      ),
    );
  }
}
