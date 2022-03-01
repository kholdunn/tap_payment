



import 'package:flutter/material.dart';

class CustomTextInputTextSuffix extends StatelessWidget {
  CustomTextInputTextSuffix(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      fit: BoxFit.scaleDown,
    );
  }

}