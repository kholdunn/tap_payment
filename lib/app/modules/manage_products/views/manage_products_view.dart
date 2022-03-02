import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/services/log.dart';
import 'package:tap_payment/app/services/ui_reference.dart';
import 'package:tap_payment/app/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:tap_payment/app/widgets/custom_text_input/custom_text_input.dart';

import '../../../widgets/custom_icon_button/custom_icon_button.dart';
import '../../../widgets/custom_text_input/custom_text_input_icon_suffix.dart';
import '../../../widgets/proceed_button/proceed_button.dart';
import '../controllers/manage_products_controller.dart';
import '../widgets/product_card.dart';

class ManageProductsView extends GetView<ManageProductsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Manage Products",
        centerTitle: true,
        actions: [
          Obx(()=>CustomIconButton(
            onPressed: (){
              controller.changeTheme();
            },
            icon: controller.themeMode.value == ThemeMode.light ? Icons.light_mode :
            controller.themeMode.value == ThemeMode.dark ? Icons.dark_mode : Icons.brightness_auto,
          )),
          CustomIconButton(
            onPressed: (){
              controller.deleteAllProduct();
            },
            icon: Icons.delete_sweep,
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onPanDown: (x){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: setupView(context),
      ),
    );
  }

  Widget setupView(BuildContext context){
    return Padding(
      child: Column(
        children: [
          CustomTextInput(
            textEditingController: controller.searchTextEditingController.value,
            onChanged: (x){

            },
            label: "Search Product",
            suffix: CustomTextInputIconSuffix(
              Icons.search_rounded,
              size: 6.w
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FutureBuilder<bool>(
                  future: controller.getData(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    Widget child;
                    if (snapshot.hasData) {
                      child = Obx(()=>ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          top: 1.7.h,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            products: controller.productList.value[index],
                            onPressed: () {
                              controller.openItem(context, product: controller.productList.value[index]);
                            },
                          );
                        },
                        itemCount: controller.productList.value.length,
                      ));
                    } else if (snapshot.hasError) {
                      child = Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          )
                        ],
                      );
                    } else {
                      child = Column(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          )
                        ],
                      );
                    }
                    return Center(
                      child: child,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: ProceedButton(
                      title: "Add Product",
                      onPressed: (){
                        controller.updateList(context);
                      },
                    ),
                    margin: EdgeInsets.only(
                      bottom: 2.35.h
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 1.5.h
      ),
    );
  }
}
