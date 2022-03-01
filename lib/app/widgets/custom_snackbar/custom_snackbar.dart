

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends Flushbar {



  CustomSnackBar( BuildContext context,{
    required String message,
    Color? titleColor,
    Color? messageColor,
    Color? iconColor,

  }) : super (
    icon: Icon(
      Icons.check,
      color: iconColor ?? Colors.green,
    ),
    titleColor: titleColor ?? Colors.green,
    message:  message,
    duration:  Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    messageColor: messageColor ?? Colors.green,
    backgroundColor: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.white,

  );




}