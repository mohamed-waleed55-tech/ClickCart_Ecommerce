// lib/widgetbook/product_details_usecase.dart

import 'package:ecommerce_app/features/home/presentation/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as widgetbook;


@widgetbook.UseCase(
  name: 'Default',
  type: ProductDetails,
)
Widget productDetailsUseCase(BuildContext context) {
  return const ProductDetails();
}