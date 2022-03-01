

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/constants/app_colors.dart';
import 'package:tap_payment/app/models/products_model.dart';
import 'package:tap_payment/app/services/debug_ui.dart';

class ProductCard extends StatelessWidget {

  ProductCard({
    required this.products,
    required this.onPressed,
    this.backgroundColor
  });
  final Products products;
  final VoidCallback onPressed;
  final Color? backgroundColor;


  @override
  Widget build(BuildContext context) {



    return Container(
        child: TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  products.productName!,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                  minFontSize: 17,
                ),
                SizedBox(height: 0.3.h,),
                AutoSizeText(
                  products.productDescription!,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 12,
                ),
                SizedBox(height: 0.5.h,),
                AutoSizeText(
                  "${products.price}",
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  minFontSize: 16,
                ),
              ],
            ),
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(
                  top: 2.h,
                  left: 4.w,
                  bottom: 2.h
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              alignment: Alignment.centerLeft,
              backgroundColor: backgroundColor ?? Theme.of(context).cardTheme.color,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )
        ),
        margin: EdgeInsets.only(
            bottom: 1.3.h
        )
    );
  }
}