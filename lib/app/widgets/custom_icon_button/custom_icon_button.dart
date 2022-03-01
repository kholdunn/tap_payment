

import 'package:flutter/material.dart';

class CustomIconButton extends IconButton {
  CustomIconButton({
    required VoidCallback? onPressed,
    required IconData icon,
    Color? iconColor
  }) : super(
    onPressed: onPressed,
    icon: Icon(
      icon
    ),
    color: iconColor
  );

}