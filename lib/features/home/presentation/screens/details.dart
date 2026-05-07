import 'package:ecommerce_app/features/home/presentation/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../model/product_model.dart';
import '../widgets/bootom_bar.dart';
import '../widgets/product_header.dart';
import '../widgets/product_info.dart';

class ProductDetails extends GetWidget<HomeViewModel> {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.arguments;


    return Scaffold(
      bottomNavigationBar: const BottomBar(price:"120"),
      body: SafeArea(
        child: Column(
          children: [
            ProductHeader(image: product.image),
             Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductInfo(product: product)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
