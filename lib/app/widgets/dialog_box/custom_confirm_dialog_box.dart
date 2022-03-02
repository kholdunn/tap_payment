

import 'package:flutter/material.dart';

class CustomConfirmDialogBox{}



Future<dynamic> showCustomConfirmDialogBox (
    BuildContext context, {
      required String title,
      required String content,
      bool? hasCancelButton,
      VoidCallback? onCancel,
      VoidCallback? onConfirm
    }){
  return showDialog(
      context: context,

      builder: (context) => AlertDialog(
        actions: [
          if(hasCancelButton ?? true)TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).inputDecorationTheme.fillColor
            ),
            onPressed: (){
              if(onCancel != null)onCancel();
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style:Theme.of(context).textTheme.bodySmall,
            ),
          ),
          TextButton(
            onPressed: (){
              if(onConfirm != null)onConfirm();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).inputDecorationTheme.fillColor
            ),
            child: Text(
              "Confirm",
              style:Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red
              ),
            )
          )
        ],
        title: Text(
            title
        ),
        content: Text(
            content
        ),
      )
  );
}