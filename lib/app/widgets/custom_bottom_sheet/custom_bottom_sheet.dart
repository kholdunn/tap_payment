

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../custom_item_list/sort_item_list.dart';
import '../proceed_button/proceed_button.dart';

class CustomBottomSheet{}


showCustomBottomSheet(
    BuildContext context,
{
  VoidCallback? onCancel,
  required List<Widget> sortItemList,
  String? title,
  String? closeButtonName = "Close"
}){
  Get.bottomSheet(
    Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(title != null)Container(
            child: Text(
              title,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            margin: EdgeInsets.only(
              bottom: 3.h
            ),
          ),
          ...sortItemList,
          Padding(
            child: ProceedButton(
              onPressed: (){
                if(onCancel != null )onCancel();
                Navigator.pop(context);
              },
              title: "$closeButtonName",
              backgroundColor: Colors.red,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.w
            ),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(
        vertical: 3.h
      ),
    ),
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Theme.of(context).backgroundColor,
    enterBottomSheetDuration: Duration(milliseconds: 200),
  );
}