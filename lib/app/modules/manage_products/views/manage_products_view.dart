import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tap_payment/app/services/log.dart';
import 'package:tap_payment/app/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:tap_payment/app/widgets/custom_text_input/custom_text_input.dart';

import '../../../widgets/custom_button/custom_button.dart';
import '../../../widgets/custom_text_input/custom_text_input_icon_suffix.dart';
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
          CustomButton(
            onPressed: (){
              controller.changeTheme();
            },
            child: Obx(()=>Icon(
                controller.themeMode.value == ThemeMode.light ? Icons.light_mode :
                controller.themeMode.value == ThemeMode.dark ? Icons.dark_mode : Icons.brightness_auto
            )),
          ),
          CustomButton(
            onPressed: (){
              controller.deleteAllProduct();
            },
            child: Icon(
              Icons.delete_sweep
            ),
          )
        ],
      ),
      body: Column(
        children: [
          CustomTextInput(
            textEditingController: controller.searchTextEditingController.value,
            onChanged: (x){

            },
            label: "Search Product",
            suffix: CustomTextInputIconSuffix(
              Icons.search_rounded,
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
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            products: controller.productList.value[index],
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
                  child: CustomButton(
                    child: Text("Add Product"),
                    onPressed: (){
                      controller.updateList();
                    },
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
