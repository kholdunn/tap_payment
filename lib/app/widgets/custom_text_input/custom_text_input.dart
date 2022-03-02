

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/services/debug_ui.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({
    this.focusNode,
    required this.textEditingController,
    this.onChanged,
    this.suffix,
    required this.label,
    this.inputFormatters,
    this.keyboardType,
    this.fillColor,
    this.readOnly,
    this.textInputAction = TextInputAction.done,
    this.validator
  });

  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  final Function(String)? onChanged;
  final Widget? suffix;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        autocorrect: false,
        focusNode: focusNode,
        controller: textEditingController,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: suffix,
          label: FittedBox(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            fit: BoxFit.scaleDown,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide.none
          ),
          fillColor: fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 1.8.h,
            horizontal: 3.w
          ),
        ),
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        textInputAction: textInputAction,
        validator: validator,
      ),
    );
  }
}