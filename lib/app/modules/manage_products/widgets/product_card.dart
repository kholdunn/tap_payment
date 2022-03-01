

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tap_payment/app/models/products_model.dart';

class ProductCard extends Container {
  ProductCard({
    required Products products
  }):super(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          products.productName!,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        AutoSizeText(
          products.productDescription!,
          style: TextStyle(
            fontSize: 20
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        AutoSizeText(
          "${products.price}",
          style: TextStyle(fontSize: 20),
          maxLines: 1,
        ),
      ],
    )
  );
}