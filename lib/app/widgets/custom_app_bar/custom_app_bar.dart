
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


enum StatusIconBrightness {black, white}

class CustomAppBar extends AppBar {

  CustomAppBar({
    String? title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
    double? fontSize = 15,
    Color? foregroundColor,
    Color? backgroundColor,
    bool? automaticallyImplyLeading = true,
    double? preferredSize,
    SystemUiOverlayStyle? systemOverlayStyle,
    StatusIconBrightness? statusIconBrightness = StatusIconBrightness.white
  }) : super(
    title: (title != "" && title != null) ? FittedBox(
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
        ),
        textAlign: TextAlign.left,
      ),
      fit: BoxFit.scaleDown,
    ) : null,
    elevation: 0,
    centerTitle: centerTitle,
    leading: leading,
    actions: actions,
    backgroundColor: backgroundColor
  );
}