

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends TextFormField {
  CustomTextInput({
    FocusNode? focusNode,
    required TextEditingController textEditingController,
    Function(String)? onChanged,
    Widget? suffix,
    required String label,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType
  }) : super(
    autocorrect: false,
    focusNode: focusNode,
    controller: textEditingController,
    onChanged: onChanged,
    decoration: InputDecoration(
      suffixIcon: suffix,
      label: Text(
        label
      )
    ),
    inputFormatters: inputFormatters,
    keyboardType: keyboardType
  );
}