
import 'package:flutter/material.dart';

class UIReference extends StatelessWidget {


  UIReference({
    required this.path,
    this.shaded = true,
    this.boxFit = BoxFit.cover,
    this.color,
    this.height,
    this.width
  });
  final String path;
  final bool? shaded;
  final BoxFit? boxFit;
  final Color? color;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {

    return Image.asset(
      "assets/screens/$path",
      width: width ?? double.maxFinite,
      height: height ?? double.maxFinite,
      fit: boxFit,
      color: color,
    );
  }

}