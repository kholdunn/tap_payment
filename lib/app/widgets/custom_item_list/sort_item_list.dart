
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/constants/app_colors.dart';

class SortItemList extends StatelessWidget {

  SortItemList({
    required this.title,
    required this.active,
    required this.onPressed
  });

  final String title;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            if(active)Icon(
              Icons.check,
              color: AppColors.pink,
            )
          ],
        ),
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 1.h
          )
        ),

        onPressed: onPressed,
      ),
      margin: EdgeInsets.only(
        bottom: 2.h
      ),
    );
  }


}