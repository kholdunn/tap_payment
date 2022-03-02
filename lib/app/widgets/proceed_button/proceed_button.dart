

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/constants/app_colors.dart';

class ProceedButton extends TextButton {

  ProceedButton({
    required VoidCallback? onPressed,
    required String title,
    Color? backgroundColor
  }) : super(
    onPressed: onPressed,
    child: FittedBox(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17
        ),
      ),
      fit: BoxFit.scaleDown,
    ),
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.pink,
      minimumSize: Size(double.maxFinite, 0),
      padding: EdgeInsets.symmetric(
        vertical: 1.8.h
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
    )
  );



}